import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:learning_app/features/themes/bloc/bloc.dart';
import 'package:learning_app/features/themes/themes.dart';
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
            onTap: () => BlocProvider.of<ThemeCubit>(context).setToDarkTheme(),
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
          ),
          InkWell(
            onTap: () => BlocProvider.of<ThemeCubit>(context).setToLightTheme(),
            child: Ink(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Center(
                child: Text(
                  "Lightmode",
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
