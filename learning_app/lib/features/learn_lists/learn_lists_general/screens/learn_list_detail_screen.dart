import 'package:flutter/material.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/widgets/learning_lists_detail_app_bar.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/widgets/term_input_field.dart';

class LearnListDetailScreen extends StatefulWidget {
  const LearnListDetailScreen({Key? key}) : super(key: key);

  @override
  State<LearnListDetailScreen> createState() => _LearnListDetailScreenState();
}

class _LearnListDetailScreenState extends State<LearnListDetailScreen> {
  final _titleController = TextEditingController();
  final _descriptionControllers = [];

  List<Widget> items = [];

  @override
  Widget build(BuildContext context) {
    //TODO: Lernliste laden, dann die Felder über den state unsichtbar / sichtbar machen
    //var newDescriptionController = TextEditingController();
    //_descriptionControllers.add(newDescriptionController);
    //items.add(ListViewItem(
    //  newDescriptionController: newDescriptionController));

    return Scaffold(
      appBar: LearnListsDetailAppBar(textController: _titleController),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                "Hier ist deine Lernliste:",
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
                  );
                },
              ),
              const SizedBox(height: 10.0),
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
