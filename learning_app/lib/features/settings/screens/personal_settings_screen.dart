import 'package:flutter/material.dart';
import 'package:learning_app/features/settings/widgets/settings_screen_base_template.dart';

class PersonalSettingsScreen extends StatelessWidget {
  const PersonalSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set initial dueDate:

    return const SettingsScreenBaseTemplate(
      title: "Persönliche Informationen",
      children: [],
    );
  }
}
