import 'package:flutter/material.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/widgets/term_input_field.dart';

class LearnListAddListViewItem extends StatelessWidget {
  const LearnListAddListViewItem(
      {Key? key,
      required this.newDescriptionController,
      required this.id,
      required this.onChange})
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
            onChange: onChange,
            id: id),
        // Only for navigation to tags
        const SizedBox(height: 20.0),
      ],
    );
  }
}
