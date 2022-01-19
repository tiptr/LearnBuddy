import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/bloc/alter_learn_list_cubit.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/dtos/learn_list_manipulation_dto.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/models/learn_list_word.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/models/learn_methods.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/widgets/learn_list_add_app_bar.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/widgets/term_input_field.dart';
import 'package:learning_app/util/logger.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

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

class _LearningAidBodyAddScreenMainElementState extends State<LearningAidBodyAddScreenMainElement> {
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
                  decoration: const BoxDecoration(
                    color: Color(0xFFCBCCCD),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              "Was möchtest du dir merken?",
              textAlign: TextAlign.left,
              overflow: TextOverflow.fade,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 8,
              itemBuilder: (context, i) {
                var newDescriptionController = TextEditingController();
                _descriptionControllers.add(newDescriptionController);
                return ListViewItem(
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
        color: Colors.white,
        body: const Image(
          image: AssetImage(
            "assets/learning_aids/moehm_alternative.png",
          ),
        ),
      ),
    );
  }

  /// Handles the 'save learn list' functionality
  Future<int?> onSaveLearnList() async {
    final cubit = BlocProvider.of<AlterLearnListCubit>(context);
    //save the words
    cubit.alterLearnListAttribute(LearnListManipulationDto(
      words: drift.Value(words),
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

class ListViewItem extends StatelessWidget {
  const ListViewItem(
      {Key? key, required this.newDescriptionController, required this.text, required this.id, required this.onChange})
      : super(key: key);

  final TextEditingController newDescriptionController;
  final String text;
  final int id;
  final Function(String, int) onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.only(left: 10.0),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
        ),
        TermInputField(
          hintText: "Text eingeben",
          iconData: Icons.edit,
          textController: newDescriptionController,
          id: id,
          onChange: onChange
        ),
      ],
    );
  }
}
