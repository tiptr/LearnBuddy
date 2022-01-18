import 'package:flutter/material.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/models/old_learning_aid_do_use_learn_list_instead.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/widgets/learn_list_card.dart';
import 'package:learning_app/shared/widgets/base_title_bar.dart';
import 'package:learning_app/shared/widgets/three_points_menu.dart';
import 'learn_list_add_screen.dart';

class LearnListsScreen extends StatelessWidget {
  const LearnListsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      // Will change to a custom title bar in the future
      appBar: BaseTitleBar(
        title: "Lernhilfen",
        actions: [
          buildThreePointsMenu(
            context: context,
            showGlobalSettings: true,
          )
        ],
      ),
      body: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 3, //state.tasks.length,
        itemBuilder: (BuildContext ctx, int idx) => const LearnListCard(
            learningAid: OldLearningAidDoUseLearnListInstead(
                id: 1, title: "Projektmanagement")),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "NavigateToLearningAidAddScreen",
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LearnListAddScreen(),
          ),
        ),
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
