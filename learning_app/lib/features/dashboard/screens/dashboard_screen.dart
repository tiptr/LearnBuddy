import 'package:flutter/material.dart';
import 'package:learning_app/features/categories/screens/category_overview_screen.dart';
import 'package:learning_app/features/dashboard/widgets/tasks_card.dart';
import 'package:learning_app/features/keywords/screens/keyword_overview_screen.dart';
import 'package:learning_app/shared/widgets/base_title_bar.dart';
import 'package:learning_app/shared/widgets/three_points_menu.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      // Will change to a custom title bar in the future
      appBar: BaseTitleBar(
        title: "Auf einen Blick",
        actions: [
          buildThreePointsMenu(
            context: context,
            showCategoryManagement: true,
            showKeyWordsManagement: true,
            showGlobalSettings: true,
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: const [
            SizedBox(height: 15.0),
            TasksCard(),
            SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}
