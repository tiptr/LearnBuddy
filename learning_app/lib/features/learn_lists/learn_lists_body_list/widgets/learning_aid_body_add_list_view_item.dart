
import 'package:flutter/material.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/widgets/term_input_field.dart';

class LearningAidBodyDetailAddListViewItem extends StatelessWidget {
  const LearningAidBodyDetailAddListViewItem(
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
