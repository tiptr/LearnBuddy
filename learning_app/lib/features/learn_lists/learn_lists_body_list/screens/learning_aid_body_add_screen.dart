import 'package:flutter/material.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/widgets/learning_aid_add_app_bar.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/widgets/term_input_field.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class LearningAidBodyAddScreen extends StatefulWidget {
  const LearningAidBodyAddScreen({Key? key}) : super(key: key);

  @override
  State<LearningAidBodyAddScreen> createState() => _LearningAidBodyAddScreenState();
}

class _LearningAidBodyAddScreenState extends State<LearningAidBodyAddScreen> {
  final _titleController = TextEditingController();
  final _descriptionControllers = [];
  List<Widget> items = [];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: LearningAidAddAppBar(textController: _titleController),
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
                  );
                },
              ),
              // Only for navigation to tags
              const SizedBox(height: 10.0)
            ],
          ),
        color: Colors.white,
        body: const Center(
          child: Text("This is the Widget behind the sliding panel"),
        ),
      )
    );
  }
}

class ListViewItem extends StatelessWidget {
  const ListViewItem({Key? key, required this.newDescriptionController})
      : super(key: key);

  final TextEditingController newDescriptionController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TermInputField(
          hintText: "Text eingeben",
          iconData: Icons.edit,
          textController: newDescriptionController,
        ),
      ],
    );
  }
}