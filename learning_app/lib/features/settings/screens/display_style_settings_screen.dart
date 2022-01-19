import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/constants/theme_color_constants.dart';
import 'package:learning_app/features/settings/widgets/settings_group.dart';
import 'package:learning_app/features/themes/bloc/bloc.dart';
import 'package:learning_app/features/themes/themes.dart';
import 'package:learning_app/shared/shared_preferences_data.dart';
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
  ThemeName? _themeName;
  @override
  Widget build(BuildContext context) {
    // Set initial dueDate:

    return ScreenWithoutBottomNavbarBaseTemplate(
      titleBar: const GoBackTitleBar(
        title: "Darstellung und Farbe",
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
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
                    _themeName =
                        BlocProvider.of<ThemeCubit>(context).toggleTheme();
                    _saveTheme();
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

  void _saveTheme() async {
    await SharedPreferencesData.storeThemeName(_themeName);
  }
}
