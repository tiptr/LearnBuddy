import 'package:flutter/material.dart';
import 'package:learning_app/features/learning_aids/models/learning_aid.dart';
import 'package:learning_app/features/learning_aids/screens/learning_aid_add_screen.dart';
import 'package:learning_app/features/learning_aids/widgets/learning_aid_card.dart';
import 'package:learning_app/shared/widgets/base_layout.dart';
import 'package:learning_app/shared/widgets/base_title_bar.dart';

class LearningAidsScreen extends StatelessWidget {
  const LearningAidsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseLayout(
        // Will change to a custom title bar in the future
        titleBar: const BaseTitleBar(
          title: "Deine Aufgaben",
        ),
        content: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: 3, //state.tasks.length,
          itemBuilder: (BuildContext ctx, int idx) => const LearningAidCard(
              learningAid: LearningAid(id: 1, title: "Projektmanagement")),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "NavigateToLearningAidAddScreen",
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LearningAidAddScreen(),
          ),
        ),
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
