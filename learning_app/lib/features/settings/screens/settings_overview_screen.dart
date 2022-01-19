import 'package:flutter/material.dart';
import 'package:learning_app/features/dashboard/screens/dashboard_screen.dart';
import 'package:learning_app/features/settings/screens/dashboard_settings_screen.dart';
import 'package:learning_app/features/settings/screens/display_style_settings_screen.dart';
import 'package:learning_app/features/settings/screens/personal_settings_screen.dart';
import 'package:learning_app/shared/widgets/go_back_title_bar.dart';
import 'package:learning_app/shared/widgets/screen_without_bottom_navbar_base_template.dart';
import 'package:learning_app/features/settings/widgets/settings_group.dart';
import 'package:learning_app/features/settings/screens/not_implemented_screen.dart';

class SettingsOverviewScreen extends StatelessWidget {
  const SettingsOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set initial dueDate:

    return ScreenWithoutBottomNavbarBaseTemplate(
      titleBar: const GoBackTitleBar(title: "Einstellungen"),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
        children: [
          _settingsGroup(
              context: context,
              title: "Persönliche Informationen",
              subtitle: "Name, Alter",
              iconData: Icons.person_outline_outlined,
              nextScreen: const PersonalSettingsScreen()),
          _settingsGroup(
              context: context,
              title: "Darstellung und Farbe",
              subtitle: "Dark / Light Mode, Highlightfarben, ...",
              iconData: Icons.palette_outlined,
              nextScreen: const DisplayStyleSettingsScreen()),
          _settingsGroup(
              context: context,
              title: "Dashboard",
              subtitle: "Anzahl Aufgaben, Ausgleichsvorschlag, ...",
              iconData: Icons.house_outlined,
              nextScreen: const DashboardSettingsScreen()),
          _settingsGroup(
              context: context,
              title: "Pomodoro-Timer",
              subtitle: "Nicht-stören-Modus, Dauer der Phasen, ...",
              iconData: Icons.av_timer_outlined,
              nextScreen: const NotImplementedScreen()),
          _settingsGroup(
              context: context,
              title: "Aufgaben",
              subtitle: "Layout der Liste",
              iconData: Icons.task_alt_outlined,
              nextScreen: const NotImplementedScreen()),
          _settingsGroup(
              context: context,
              title: "Ausgleichsvorschläge",
              subtitle: "Welche Vorschläge angezeigt werden sollen",
              iconData: Icons.local_florist_outlined,
              nextScreen: const NotImplementedScreen()),
          _settingsGroup(
              context: context,
              title: "Lernhilfen",
              subtitle: "Körpermethode: Standardansicht, ...",
              iconData: Icons.library_books_outlined,
              nextScreen: const NotImplementedScreen()),
          _settingsGroup(
              context: context,
              title: "Über die App",
              subtitle: "Urheber, Ziele, ...",
              iconData: Icons.info_outline,
              nextScreen: const NotImplementedScreen()),
        ],
      ),
    );
  }

  Widget _settingsGroup(
      {required BuildContext context,
      required String title,
      required String subtitle,
      required IconData iconData,
      required Widget nextScreen}) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => nextScreen,
        ),
      ),
      child: Ink(
        child: SettingsGroup(
          title: title,
          subTitle: subtitle,
          iconData: iconData,
          colorHard: true,
        ),
      ),
    );
  }
}
