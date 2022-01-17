import 'package:flutter/material.dart';
import 'package:learning_app/features/learning_aids/widgets/learning_aid_add_app_bar.dart';
import 'package:learning_app/features/learning_aids/widgets/term_input_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: SizedBox(
                           width: MediaQuery.of(context).size.width,
                           height: MediaQuery.of(context).size.height * 0.25,
                           child: SvgPicture.asset(
                'assets/leisure/leisure-group-fitness.png',
                color: Colors.cyan,
              ),
                         )),
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
