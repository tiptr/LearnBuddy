import 'package:flutter/material.dart';
import 'package:learning_app/features/categories/screens/category_overview_screen.dart';
import 'package:learning_app/features/dashboard/widgets/tasks_card.dart';
import 'package:learning_app/features/keywords/screens/keyword_overview_screen.dart';
import 'package:learning_app/features/settings/screens/settings_overview_screen.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/shared/widgets/base_layout.dart';
import 'package:learning_app/shared/widgets/base_title_bar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      titleBar: const BaseTitleBar(title: "Heutige Aufgaben"),
      content: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(15.0),
        children: [
          const TasksCard(),
          const SizedBox(height: 30.0),
          // TODO: The following three InkWells are dummy elements for testing
          // Category Button
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
              child: Center(
                child: Text(
                  "Kategorien verwalten",
                  style: Theme.of(context).textTheme.textStyle3.withOnPrimary,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          // Keyword Button
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
              child: Center(
                child: Text(
                  "Schlagwörter verwalten",
                  style: Theme.of(context).textTheme.textStyle3.withOnPrimary,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          // Settings Button
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsOverviewScreen(),
              ),
            ),
            child: Ink(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Center(
                child: Text(
                  "Einstellungen",
                  style: Theme.of(context).textTheme.textStyle3.withOnPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
