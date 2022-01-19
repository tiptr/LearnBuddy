import 'dart:math';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learning_app/constants/basic_card.dart';
import 'package:learning_app/features/learn_lists/learn_lists_body_list/widgets/learning_aid_body_add_list_view_item.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/bloc/alter_learn_list_cubit.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/dtos/learn_list_manipulation_dto.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/models/learn_list_word.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/models/learn_methods.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/widgets/learn_list_add_app_bar.dart';
import 'package:learning_app/util/logger.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:learning_app/constants/theme_font_constants.dart';

class LearningAidBodyAddScreen extends StatelessWidget {
  const LearningAidBodyAddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AlterLearnListCubit>(
      lazy: true,
      create: (context) {
        return AlterLearnListCubit();
      },
      child: const LearningAidBodyAddScreenMainElement(),
    );
  }
}

class LearningAidBodyAddScreenMainElement extends StatefulWidget {
  const LearningAidBodyAddScreenMainElement({Key? key}) : super(key: key);

  @override
  State<LearningAidBodyAddScreenMainElement> createState() =>
      _LearningAidBodyAddScreenMainElementState();
}

class _LearningAidBodyAddScreenMainElementState
    extends State<LearningAidBodyAddScreenMainElement> {
  final _titleController = TextEditingController();
  final _descriptionControllers = [];
  List<Widget> items = [];
  List<String> bodyParts = [
    "Kopf:",
    "Brust:",
    "Ellenbogen:",
    "Hände:",
    "Bauch:",
    "Po:",
    "Knie:",
    "Füße:"
  ];
  List<LearnListWord> words = [];

  @override
  void initState() {
    super.initState();

    BlocProvider.of<AlterLearnListCubit>(context)
        .startNewLearnListConstruction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LearnListAddAppBar(
        textController: _titleController,
        onSaveLearnList: onSaveLearnList,
      ),
      body: SlidingUpPanel(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18.0),
          topRight: Radius.circular(18.0),
        ),
        parallaxEnabled: true,
        parallaxOffset: .0,
        panelSnapping: true,
        minHeight: 145,
        maxHeight: MediaQuery.of(context).size.height * 0.80,
        panel: Column(
          children: [
            // The indicator on top showing the draggability of the panel
            InkWell(
              child: Center(
                heightFactor: 5,
                child: Container(
                  height: 5,
                  width: 80,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(BasicCard.borderRadius)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              "Was möchtest du dir merken?",
              textAlign: TextAlign.left,
              overflow: TextOverflow.fade,
              style: Theme.of(context).textTheme.textStyle2.withBold,
            ),
            const SizedBox(height: 10.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 8,
              itemBuilder: (context, i) {
                var newDescriptionController = TextEditingController();
                _descriptionControllers.add(newDescriptionController);
                return LearningAidBodyDetailAddListViewItem(
                  newDescriptionController: _descriptionControllers[i],
                  text: bodyParts[i],
                  id: i,
                  onChange: onChangeText,
                );
              },
            ),
            // Only for navigation to tags
            const SizedBox(height: 10.0)
          ],
        ),
        color: Theme.of(context).colorScheme.background,
        body: SvgPicture.asset(
          "assets/learning_aids/moehm_alternative.svg",
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
    for (int i = 0; i < words.length; i++) {
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

    return await cubit.saveLearnList(LearnMethods.bodyList);
  }

  void onChangeText(String text, int id) async {
    bool containsElementWithSameId = false;
    LearnListWord? elementToOverwrite;

    for (LearnListWord word in words) {
      if (word.id == id) {
        containsElementWithSameId = true;
        elementToOverwrite = word;
      }
    }

    if (containsElementWithSameId) {
      words.remove(elementToOverwrite);
      words.add(LearnListWord(id: id, word: text));
    } else {
      words.add(LearnListWord(id: id, word: text));
    }
  }
}
