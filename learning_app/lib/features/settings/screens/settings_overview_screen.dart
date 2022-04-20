import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/constants/settings_constants.dart';
import 'package:learning_app/constants/theme_color_constants.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/features/settings/screens/dashboard_settings_screen.dart';
import 'package:learning_app/features/settings/screens/display_style_settings_screen.dart';
import 'package:learning_app/features/settings/screens/personal_settings_screen.dart';
import 'package:learning_app/features/settings/screens/pomodoro_settings_screen.dart';
import 'package:learning_app/features/settings/screens/storage_settings_screen.dart';
import 'package:learning_app/features/themes/bloc/bloc.dart';
import 'package:learning_app/shared/open_confirm_dialog.dart';
import 'package:learning_app/shared/shared_preferences_data.dart';
import 'package:learning_app/shared/widgets/go_back_title_bar.dart';
import 'package:learning_app/shared/widgets/screen_without_bottom_navbar_base_template.dart';
import 'package:learning_app/features/settings/widgets/settings_group.dart';
import 'package:learning_app/features/settings/screens/not_implemented_screen.dart';
import 'package:learning_app/shared/widgets/three_points_menu.dart';
import 'package:learning_app/util/logger.dart';

class SettingsOverviewScreen extends StatelessWidget {
  const SettingsOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set initial dueDate:

    return ScreenWithoutBottomNavbarBaseTemplate(
      titleBar: GoBackTitleBar(
        title: "Einstellungen",
        actionWidget: buildThreePointsMenu(
            context: context,
            showResetSettings: true,
            onResetSettings: () => _resetSettings(context)),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
        children: [
          _settingsGroup(
              context: context,
              title: "Persönliche Informationen",
              subtitle: "Name, Alter",
              iconData: Icons.person_outline_outlined,
              nextScreen: const PersonalSettingsScreen()),
          _settingsGroup(
              context: context,
              title: "Darstellung und Farbe",
              subtitle: "Dark / Light Mode, Highlightfarben, ...",
              iconData: Icons.palette_outlined,
              nextScreen: const DisplayStyleSettingsScreen()),
          _settingsGroup(
              context: context,
              title: "Dashboard",
              subtitle: "Anzahl Aufgaben, Ausgleichsvorschlag, ...",
              iconData: Icons.house_outlined,
              nextScreen: const DashboardSettingsScreen()),
          _settingsGroup(
              context: context,
              title: "Pomodoro-Timer",
              subtitle: "Nicht-stören-Modus, Dauer der Phasen, ...",
              iconData: Icons.av_timer_outlined,
              nextScreen: const PomodoroSettingsScreen()),
          _settingsGroup(
              context: context,
              title: "Aufgaben",
              subtitle: "Layout der Liste",
              iconData: Icons.task_alt_outlined,
              nextScreen: const NotImplementedScreen()),
          _settingsGroup(
              context: context,
              title: "Ausgleichsvorschläge",
              subtitle: "Welche Vorschläge angezeigt werden sollen",
              iconData: Icons.local_florist_outlined,
              nextScreen: const NotImplementedScreen()),
          _settingsGroup(
              context: context,
              title: "Lernhilfen",
              subtitle: "Körpermethode: Standardansicht, ...",
              iconData: Icons.library_books_outlined,
              nextScreen: const NotImplementedScreen()),
          _settingsGroup(
              context: context,
              title: "Speicher und Daten",
              subtitle: "Speicherort, Export & Import...",
              iconData: Icons.sd_storage_outlined,
              nextScreen: const StorageSettingsScreen()),
          _settingsGroup(
              context: context,
              title: "Über die App",
              subtitle: "Urheber, Ziele, ...",
              iconData: Icons.info_outline,
              nextScreen: const NotImplementedScreen()),
        ],
      ),
    );
  }

  Widget _settingsGroup(
      {required BuildContext context,
      required String title,
      required String subtitle,
      required IconData iconData,
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
          iconData: iconData,
          colorHard: true,
        ),
      ),
    );
  }

  _resetSettings(BuildContext context) async {
    var confirmed = await openConfirmDialog(
        context: context,
        title: "Einstellungen zurücksetzen?",
        content: Text(
          "Willst du die Einstellungen wirklich vollständig zurücksetzen?\n\nDu musst eventuell die App neu starten, damit alle Änderungen in Kraft treten.",
          style: Theme.of(context)
              .textTheme
              .textStyle2
              .withOverflow(TextOverflow.visible),
        ));

    if (confirmed) {
      logger.d('Einstellungen werden zurückgesetzt');
      SharedPreferencesData.resetSettings();
      BlocProvider.of<ThemeCubit>(context).setToTheme(defaultThemeName);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Einstellungen erfolgreich zurückgesetzt!',
            style: Theme.of(context).textTheme.textStyle2.withSucess,
          ),
          backgroundColor: Theme.of(context).colorScheme.subtleBackgroundGrey,
        ),
      );
    }
  }
}
