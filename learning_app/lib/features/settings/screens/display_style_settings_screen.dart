import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/constants/theme_color_constants.dart';
import 'package:learning_app/features/settings/widgets/settings_group.dart';
import 'package:learning_app/features/themes/bloc/bloc.dart';
import 'package:learning_app/shared/widgets/go_back_title_bar.dart';
import 'package:learning_app/shared/widgets/screen_without_bottom_navbar_base_template.dart';

class DisplayStyleSettingsScreen extends StatefulWidget {
  const DisplayStyleSettingsScreen({Key? key}) : super(key: key);

  @override
  State<DisplayStyleSettingsScreen> createState() =>
      _DisplayStyleSettingsScreenState();
}

/// private State class that goes with MyStatefulWidget
class _DisplayStyleSettingsScreenState
    extends State<DisplayStyleSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    // Set initial dueDate:

    return ScreenWithoutBottomNavbarBaseTemplate(
      titleBar: const GoBackTitleBar(title: "Darstellung und Farbe"),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(10.0),
        children: [
          SettingsGroup(
            title: "Darkmode",
            subTitle: "Verwendet dunklere Farben",
            iconData: Icons.dark_mode_outlined,
            action: BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) => Switch(
                value: state.isDark,
                onChanged: (value) {
                  setState(() {
                    BlocProvider.of<ThemeCubit>(context).toggleTheme();
                  });
                },
                activeColor: Theme.of(context).colorScheme.primary,
                inactiveThumbColor: Theme.of(context).colorScheme.cardColor,
                inactiveTrackColor:
                    Theme.of(context).colorScheme.onBackgroundSoft,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
