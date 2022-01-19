import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/bloc/alter_learn_list_state.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/dtos/create_learn_list_dto.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/dtos/learn_list_manipulation_dto.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/models/learn_methods.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/repositories/learn_list_repository.dart';
import 'package:learning_app/util/injection.dart';
import 'package:learning_app/util/logger.dart';
import 'package:logger/logger.dart';

class AlterLearnListCubit extends Cubit<AlterLearnListState> {
  late final LearnListRepository _learnListRepository;

  AlterLearnListCubit({
    LearnListRepository? learnListRepository,
  }) : super(WaitingForAlterLearnListState()) {
    _learnListRepository = learnListRepository ?? getIt<LearnListRepository>();
  }

  /// Begins the construction of a new learn list
  void startNewLearnListConstruction() {
    final currentState = state;
    if (currentState is WaitingForAlterLearnListState) {
      emit(ConstructingNewLearnList(
        createLearnListDto: CreateLearnListDto(),
      ));
    }

    // TODO: handle other states
  }

  /// To be called while in 'ConstructingNewLearnList' or 'AlteringExistingLearnList' state.
  ///
  /// This will update the present values provided in 'newDto' in the current
  /// construction-dto.
  /// Writing to the database only happens centrally, when 'saveLearnList()' is
  /// triggered.
  void alterLearnListAttribute(LearnListManipulationDto newDto) {
    final currentState = state;

    if (currentState is ConstructingNewLearnList) {
      // Add the given learn list attributes to the currently constructed learn list
      ConstructingNewLearnList constructingState = currentState;
      constructingState.createLearnListDto.applyChangesFrom(newDto);
      emit(constructingState);
    } else {
      log('Learn list attribute altered when not in a construction state!',
          level: Level.error.index);
    }
  }

  /// Returns whether the learn list is ready to be saved
  bool validateLearnListConstruction() {
    final currentState = state;
    if (currentState is ConstructingNewLearnList) {
      ConstructingNewLearnList constructingState = currentState;
      return constructingState.createLearnListDto.isReadyToStore;
    } else {
      logger.d(
          'Task construction validation triggered, but not in a construction state');
      return false;
    }
  }

  /// Returns a string that explains, which fields are still missing for
  /// the validation to succeed
  String? getMissingFieldsDescription() {
    final currentState = state;
    if (currentState is ConstructingNewLearnList) {
      ConstructingNewLearnList constructingState = currentState;
      return constructingState.createLearnListDto.missingFieldsDescription;
    } else {
      logger.d(
          'Task construction validation triggered, but not in a construction state');
      return null;
    }
  }

  /// Finishes the construction of a new learn list or the update of an existing one
  /// by storing it in the database
  Future<int?> saveLearnList(LearnMethods method) async {
    final currentState = state;
    if (currentState is ConstructingNewLearnList) {
      // Save the learn list, if all required attributes are given
      ConstructingNewLearnList constructingState = currentState;
      if (constructingState.createLearnListDto.isReadyToStore) {
        int newLearnListId =
            await _learnListRepository.createLearnList(constructingState.createLearnListDto, method);
        logger.d("[Learn List Cubit] New learn list was saved. Id: $newLearnListId");
        emit(WaitingForAlterLearnListState());
        return newLearnListId;
      } else {
        // Not all requirements given
        logger.d(
            "[Learn List Cubit] Save learn list triggered, but not every required attribute was set");
        emit(ConstructingNewLearnList(createLearnListDto: currentState.createLearnListDto));
        return null;
      }
    } else {
      // The task has to be constructed first with 'addTaskAttribute'
      logger.d(
          "[Task Cubit] Save task triggered without being in a constructing state.");
      return null;
    }
  }
}
