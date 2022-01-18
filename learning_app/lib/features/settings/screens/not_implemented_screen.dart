import 'package:flutter/material.dart';
import 'package:learning_app/shared/widgets/go_back_title_bar.dart';
import 'package:learning_app/shared/widgets/screen_without_bottom_navbar_base_template.dart';
import 'package:learning_app/constants/theme_font_constants.dart';

class NotImplementedScreen extends StatelessWidget {
  const NotImplementedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set initial dueDate:

    return ScreenWithoutBottomNavbarBaseTemplate(
      titleBar: const GoBackTitleBar(title: "Nicht Implementiert"),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(10.0),
        children: [
          Center(
              child: Text("...kommt aber bald!",
                  style: Theme.of(context).textTheme.textStyle2))
        ],
      ),
    );
  }
}
