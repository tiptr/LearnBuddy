import 'package:flutter/material.dart';
import 'package:learning_app/constants/settings_constants.dart';
import 'package:learning_app/constants/settings_spacer.dart';
import 'package:learning_app/features/dashboard/widgets/leisure_card.dart';
import 'package:learning_app/features/dashboard/widgets/tasks_card.dart';
import 'package:learning_app/shared/shared_preferences_data.dart';
import 'package:learning_app/shared/widgets/base_title_bar.dart';
import 'package:learning_app/shared/widgets/three_points_menu.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

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
      body: Scrollbar(
        controller: _scrollController,
        interactive: true,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                    const SizedBox(height: 15.0),
                    const TasksCard(),
                    spacer,
                  ] +
                  (SharedPreferencesData.displayLeisureOnDashboard ??
                          defaultDisplayLeisureOnDashboard
                      ? const [LeisureCard(), SizedBox(height: 30.0)]
                      : []),
            ),
          ),
        ),
      ),
    );
  }
}
