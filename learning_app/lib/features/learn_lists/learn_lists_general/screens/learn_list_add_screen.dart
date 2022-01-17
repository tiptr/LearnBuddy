import 'package:flutter/material.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/widgets/learn_list_add_app_bar.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/widgets/term_input_field.dart';

class LearnListAddScreen extends StatefulWidget {
  const LearnListAddScreen({Key? key}) : super(key: key);

  @override
  State<LearnListAddScreen> createState() => _LearnListAddScreenState();
}

class _LearnListAddScreenState extends State<LearnListAddScreen> {
  final _titleController = TextEditingController();
  final _descriptionControllers = [];

  List<Widget> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LearnListAddAppBar(textController: _titleController),
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
                  return ListViewItem(
                    newDescriptionController: _descriptionControllers[i],
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
                        newDescriptionController: newDescriptionController));
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
        // Only for navigation to tags
        const SizedBox(height: 20.0),
      ],
    );
  }
}
