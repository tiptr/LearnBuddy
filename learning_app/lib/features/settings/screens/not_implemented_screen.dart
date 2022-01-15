import 'package:flutter/material.dart';
import 'package:learning_app/features/settings/widgets/settings_screen_base_template.dart';
import 'package:learning_app/constants/theme_font_constants.dart';

class NotImplementedScreen extends StatelessWidget {
  const NotImplementedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set initial dueDate:

    return SettingsScreenBaseTemplate(
      title: "Nicht Implementiert",
      children: [
        Center(
            child: Text("...kommt aber bald!",
                style: Theme.of(context).textTheme.textStyle2))
      ],
    );
  }
}
