import 'package:flutter/material.dart';
import 'package:learning_app/shared/widgets/go_back_title_bar.dart';
import 'package:learning_app/shared/widgets/screen_without_bottom_navbar_base_template.dart';
import 'package:learning_app/constants/theme_font_constants.dart';

class PersonalSettingsScreen extends StatelessWidget {
  const PersonalSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set initial dueDate:

    return ScreenWithoutBottomNavbarBaseTemplate(
      titleBar: const GoBackTitleBar(title: "Persönliche Informationen"),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(10.0),
        children: [
          Text(
            "Was passiert mit diesen Daten?",
            style: Theme.of(context).textTheme.textStyle2.withBold,
          ),
          // TODO: Look at StrutStyle for Text spacing
          const SizedBox(
            height: 5.0,
          ),
          Text(
            "Wie auch alle anderen in dieser App hinterlegten Daten bleiben diese Informationen auf deinem Gerät gespeichert und werden nicht an uns oder Dritte übertragen. Sie dienen lediglich der personifizierten Ansprache durch die App und der Vorkonfiguration von Einstellungen.",
            style: Theme.of(context).textTheme.settingsInfoTextStyle,
          )
        ],
      ),
    );
  }
}
