import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/bloc/alter_learn_list_cubit.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/models/learn_list_word.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/models/learn_methods.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/widgets/learn_list_add_app_bar.dart';
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
      child: const LearnListAddScreenMainElement(),
    );
  }
}

class LearnListAddScreenMainElement extends StatefulWidget {
  const LearnListAddScreenMainElement({Key? key}) : super(key: key);

  @override
  State<LearnListAddScreenMainElement> createState() => _LearnListAddScreenMainElementState();
}

class _LearnListAddScreenMainElementState extends State<LearnListAddScreenMainElement> {
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
                  return ListViewItem(
                    newDescriptionController: _descriptionControllers[i],
                    id: idCount++,
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
                    items.add(ListViewItem(
                        newDescriptionController: newDescriptionController,
                        id: idCount++,
                        onChange: onChangeText));
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
    // validate required fields:
    if (!cubit.validateLearnListConstruction()) {
      // Not ready to save! Inform the user and continue
      final missingFieldsDescr = cubit.getMissingFieldsDescription();
      logger.d(
          'The task is not ready to be saved! Description: $missingFieldsDescr');
      // TODO: inform the user with a SnackBar
      return null;
    }

    return await BlocProvider.of<AlterLearnListCubit>(context).saveLearnList(LearnMethods.bodyList);
  }

  void onChangeText(String text, int id) async {
    words.add(LearnListWord(id: id, word: text));
  }
}

class ListViewItem extends StatelessWidget {
  const ListViewItem({Key? key, required this.newDescriptionController, required this.id, required this.onChange})
      : super(key: key);

  final TextEditingController newDescriptionController;
  final int id;
  final Function(String, int) onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TermInputField(
          hintText: "Text eingeben",
          iconData: Icons.edit,
          textController: newDescriptionController,
          onChange: onChange
        ),
        // Only for navigation to tags
        const SizedBox(height: 20.0),
      ],
    );
  }
}
