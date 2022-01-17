import 'package:flutter/material.dart';
import 'package:learning_app/features/categories/screens/category_overview_screen.dart';
import 'package:learning_app/features/dashboard/widgets/tasks_card.dart';
import 'package:learning_app/features/keywords/screens/keyword_overview_screen.dart';
import 'package:learning_app/shared/widgets/base_title_bar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      // Will change to a custom title bar in the future
      appBar: const BaseTitleBar(
        title: "Auf einen Blick",
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            const SizedBox(height: 15.0),
            const TasksCard(),
            const SizedBox(height: 30.0),
            // TODO: The following two InkWells are dummy elements for testing
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CategoryOverviewScreen(),
                ),
              ),
              child: Ink(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: const Center(
                  child: Text(
                    "Kategorien verwalten",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const KeyWordOverviewScreen(),
                ),
              ),
              child: Ink(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: const Center(
                  child: Text(
                    "Schlagwörter verwalten",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
