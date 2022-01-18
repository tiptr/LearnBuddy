import 'package:flutter/material.dart';
import 'package:learning_app/shared/widgets/go_back_title_bar.dart';
import 'package:learning_app/shared/widgets/screen_without_bottom_navbar_base_template.dart';
import 'package:learning_app/constants/theme_font_constants.dart';

class DisplayStyleSettingsScreen extends StatelessWidget {
  const DisplayStyleSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set initial dueDate:

    return ScreenWithoutBottomNavbarBaseTemplate(
      titleBar: const GoBackTitleBar(title: "Darstellung und Farbe"),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(10.0),
        children: [
          InkWell(
            onTap: () => {},
            child: Ink(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Center(
                child: Text(
                  "Darkmode",
                  style: Theme.of(context).textTheme.textStyle3.withOnPrimary,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
