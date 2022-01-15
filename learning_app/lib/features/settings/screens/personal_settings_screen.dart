import 'package:flutter/material.dart';
import 'package:learning_app/features/settings/widgets/settings_screen_base_template.dart';

class PersonalSettingsScreen extends StatelessWidget {
  const PersonalSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set initial dueDate:

    return const SettingsScreenBaseTemplate(
      title: "Persönliche Informationen",
      children: [
        Text(
          "Was passiert mit diesen Daten?",
          style: TextStyle(
            height: 2,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF636573),
          ),
        ),
        Text(
          "Wie auch alle anderen in dieser App hinterlegten Daten bleiben diese Informationen auf deinem Gerät gespeichert und werden nicht an uns oder Dritte übertragen. Sie dienen lediglich der personifizierten Ansprache durch die App und der Vorkonfiguration von Einstellungen.",
          style: TextStyle(
            height: 2,
            fontSize: 12.0,
            fontWeight: FontWeight.normal,
            // overflow: TextOverflow.ellipsis,
            color: Color(0xFF636573),
          ),
        )
      ],
    );
  }
}
