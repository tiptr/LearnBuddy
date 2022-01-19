import 'dart:math';

import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/bloc/alter_learn_list_cubit.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/dtos/learn_list_manipulation_dto.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/models/learn_list_word.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/models/learn_methods.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/widgets/learn_list_add_app_bar.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/widgets/learn_list_add_list_view_item.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/widgets/term_input_field.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/util/logger.dart';

class LearnListAddScreen extends StatelessWidget {

  const LearnListAddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AlterLearnListCubit>(
      lazy: true,
      create: (context) {
        return AlterLearnListCubit();
      },
      child: const _LearnListAddScreenMainElement(),
    );
  }
}

class _LearnListAddScreenMainElement extends StatefulWidget {
  const _LearnListAddScreenMainElement({Key? key}) : super(key: key);

  @override
  State<_LearnListAddScreenMainElement> createState() => _LearnListAddScreenMainElementState();
}

class _LearnListAddScreenMainElementState extends State<_LearnListAddScreenMainElement> {
  final _titleController = TextEditingController();
  final _descriptionControllers = [];

  List<Widget> items = [];
  List<LearnListWord> words = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AlterLearnListCubit>(context)
        .startNewLearnListConstruction();
  }

  int idCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LearnListAddAppBar(
        textController: _titleController,
        onSaveLearnList: onSaveLearnList,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                "Was möchtest du dir merken?",
                textAlign: TextAlign.left,
                overflow: TextOverflow.fade,
                style: Theme.of(context)
                    .textTheme
                    .textStyle2
                    .withBold
                    .withOnBackgroundSoft,
              ),
              const SizedBox(height: 40.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, i) {
                  return LearnListAddListViewItem(
                    newDescriptionController: _descriptionControllers[i],
                    id: i,
                    onChange: onChangeText,
                  ); // item layout
                },
              ),
              // Only for navigation to tags
              const SizedBox(height: 10.0),
              InkWell(
                onTap: () {
                  setState(() {
                    var newDescriptionController = TextEditingController();
                    _descriptionControllers.add(newDescriptionController);
                    // add another item to the list
                    //items.add(items.length);
                    items.add(LearnListAddListViewItem(
                        newDescriptionController: newDescriptionController,
                        id: idCount,
                        onChange: onChangeText));
                    idCount++;
                  });
                },
                child: Ink(
                  width: 200,
                  height: 50,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add,
                            size: 30.0,
                            color: Theme.of(context).colorScheme.primary),
                        Text("Neuer Begriff",
                            style: Theme.of(context)
                                .textTheme
                                .textStyle2
                                .withPrimary),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Handles the 'save learn list' functionality
  Future<int?> onSaveLearnList() async {
    final cubit = BlocProvider.of<AlterLearnListCubit>(context);
    //save the words
    //TODO: replace this in the future
    //generate random ids (that are ascendent)
    var rdm = Random();
    var startId = rdm.nextInt(4294967280);
    final List<LearnListWord> wordsWithRandomIds = [];
    for(int i = 0; i < words.length; i++){
      wordsWithRandomIds.add(LearnListWord(id: startId++, word: words[i].word));
    }
    cubit.alterLearnListAttribute(LearnListManipulationDto(
      words: drift.Value(wordsWithRandomIds),
    ));

    // validate required fields:
    if (!cubit.validateLearnListConstruction()) {
      // Not ready to save! Inform the user and continue
      final missingFieldsDescr = cubit.getMissingFieldsDescription();
      logger.d(
          'The task is not ready to be saved! Description: $missingFieldsDescr');
      // TODO: inform the user with a SnackBar
      return null;
    }

    return await cubit.saveLearnList(LearnMethods.simpleLearnList);
  }

  void onChangeText(String text, int id) async {
    bool containsElementWithSameId = false;
    LearnListWord? elementToOverwrite;

    for(LearnListWord word in words) {
      if(word.id == id) {
        containsElementWithSameId = true;
        elementToOverwrite = word;
      }
    }

    if(containsElementWithSameId) {
      words.remove(elementToOverwrite);
      words.add(LearnListWord(id: id, word: text));
    } else {
      words.add(LearnListWord(id: id, word: text));
    }
  }
}
