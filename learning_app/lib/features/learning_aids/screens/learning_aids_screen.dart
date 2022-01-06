import 'package:flutter/material.dart';
import 'package:learning_app/features/learning_aids/models/learning_aid.dart';
import 'package:learning_app/features/learning_aids/screens/learning_aid_add_screen.dart';
import 'package:learning_app/features/learning_aids/widgets/learning_aid_card.dart';

class LearningAidsScreen extends StatelessWidget {
  const LearningAidsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 1, //state.tasks.length,
        itemBuilder: (BuildContext ctx, int idx) => const LearningAidCard(
            learningAid: LearningAid(id: 1, title: "Projektmanagement")),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "NavigateToLearningAidAddScreen",
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LearningAidAddScreen(),
          ),
        ),
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
