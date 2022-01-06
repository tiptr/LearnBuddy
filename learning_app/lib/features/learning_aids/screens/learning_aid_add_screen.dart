import 'package:flutter/material.dart';
import 'package:learning_app/features/categories/screens/category_overview_screen.dart';
import 'package:learning_app/features/learning_aids/widgets/learning_aid_add_app_bar.dart';
import 'package:learning_app/features/learning_aids/widgets/term_input_field.dart';

class LearningAidAddScreen extends StatefulWidget {
  const LearningAidAddScreen({Key? key}) : super(key: key);

  @override
  State<LearningAidAddScreen> createState() => _LearningAidAddScreenState();
}

class _LearningAidAddScreenState extends State<LearningAidAddScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  List<Widget> items = [];

  Widget listViewItem() {
    // widget layout for listview items
    return Column(
      children: [
        TermInputField(
          hintText: "Text eingeben",
          iconData: Icons.edit,
          textController: _descriptionController,
        ),
        // Only for navigation to tags
        const SizedBox(height: 20.0),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LearningAidAddAppBar(textController: _titleController),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
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
              const SizedBox(height: 40.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, i) {
                  return listViewItem(); // item layout
                },
              ),
              // Only for navigation to tags
              const SizedBox(height: 10.0),
              InkWell(
                onTap: () {
                  setState(() {
                    // add another item to the list
                    //items.add(items.length);
                    items.add(listViewItem());
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
                        Text(
                          "Neuer Begriff",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 18,
                          ),
                        ),
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
}
