import 'package:flutter/material.dart';
import 'package:learning_app/features/settings/widgets/settings_group.dart';
import 'package:learning_app/shared/widgets/go_back_title_bar.dart';
import 'package:learning_app/features/settings/screens/not_implemented_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set initial dueDate:

    return Scaffold(
      appBar: const GoBackTitleBar(
        title: "Einstellungen",
      ),
      body: ListView(
        // margin: const EdgeInsets.all(20.0),
        shrinkWrap: true,
        padding: const EdgeInsets.all(15.0),
        children: [
          _settingsGroup(
              context: context,
              title: "Persönliche Informationen",
              subtitle: "Name, Alter",
              icon: const Icon(Icons.person_outline_outlined),
              nextScreen: const NotImplementedScreen()),
          _settingsGroup(
              context: context,
              title: "Darstellung und Farbe",
              subtitle: "Dark / Light Mode, Highlightfarben, ...",
              icon: const Icon(Icons.palette_outlined),
              nextScreen: const NotImplementedScreen()),
          _settingsGroup(
              context: context,
              title: "Dashboard",
              subtitle: "Anzahl Aufgaben, Ausgleichsvorschlag, ...",
              icon: const Icon(Icons.house_outlined),
              nextScreen: const NotImplementedScreen()),
          _settingsGroup(
              context: context,
              title: "Pomodoro-Timer",
              subtitle: "Nicht-stören-Modus, Dauer der Phasen, ...",
              icon: const Icon(Icons.av_timer_outlined),
              nextScreen: const NotImplementedScreen()),
          _settingsGroup(
              context: context,
              title: "Aufgaben",
              subtitle: "Layout der Liste",
              icon: const Icon(Icons.task_alt_outlined),
              nextScreen: const NotImplementedScreen()),
          _settingsGroup(
              context: context,
              title: "Ausgleichsvorschläge",
              subtitle: "",
              icon: const Icon(Icons.local_florist_outlined),
              nextScreen: const NotImplementedScreen()),
          _settingsGroup(
              context: context,
              title: "Lernhilfen",
              subtitle: "Körpermethode: Standardansicht, ...",
              icon: const Icon(Icons.library_books_outlined),
              nextScreen: const NotImplementedScreen()),
          _settingsGroup(
              context: context,
              title: "Über die App",
              subtitle: "Urheber, Ziele, ...",
              icon: const Icon(Icons.info_outline),
              nextScreen: const NotImplementedScreen()),
        ],
      ),
    );
  }

  Widget _settingsGroup(
      {required BuildContext context,
      required String title,
      required String subtitle,
      required Icon icon,
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
          icon: icon,
        ),
      ),
    );
  }
}
