import 'package:flutter/material.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/models/learning_aid.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/screens/learning_aid_add_screen.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/screens/learning_aid_body_add_screen.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/widgets/learning_aid_card.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LearningAidsScreen extends StatelessWidget {
  const LearningAidsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 3, //state.tasks.length,
        itemBuilder: (BuildContext ctx, int idx) => const LearningAidCard(
            learningAid: LearningAid(id: 1, title: "Projektmanagement")),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "NavigateToLearningAidAddScreen",
        onPressed: () => _openPopup(context),
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  _openPopup(context) {
    Alert(
        context: context,
        title: "Art der Lernhilfe",
        content: Column(
          children: [
            CustomButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LearningAidBodyAddScreen(),
                ),
        )     ,
              icon: Icons.accessibility_new_rounded,
              text: "Begriffe an Körperteile binden",
            ),
            const Divider(
              color: Colors.black
            ),
            CustomButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LearningAidAddScreen(),
                ),
        )     ,
              icon: Icons.format_list_bulleted,
              text: "Begriffsliste                              ", //makes the buttons equally sized:)
            )
          ],
        ),
        buttons: [
          //has to be empty, otherwise a "cancel" button will be inserted by default
        ]).show();
  }
}


class CustomButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final IconData icon;
  final String text; 

  const CustomButton({required this.onPressed, required this.icon, required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.black,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              text,
              maxLines: 1,
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      onPressed: onPressed,
      elevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
    );
  }
}