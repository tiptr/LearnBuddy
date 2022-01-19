import 'package:flutter/material.dart';
import 'package:learning_app/constants/settings_constants.dart';
import 'package:learning_app/constants/settings_spacer.dart';
import 'package:learning_app/constants/theme_color_constants.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/features/settings/widgets/settings_group.dart';
import 'package:learning_app/shared/shared_preferences_data.dart';
import 'package:learning_app/shared/widgets/go_back_title_bar.dart';
import 'package:learning_app/shared/widgets/inputfields/number_input_field.dart';
import 'package:learning_app/shared/widgets/screen_without_bottom_navbar_base_template.dart';

class DashboardSettingsScreen extends StatefulWidget {
  const DashboardSettingsScreen({Key? key}) : super(key: key);

  @override
  State<DashboardSettingsScreen> createState() =>
      _DashboardSettingsScreenState();
}

/// private State class that goes with MyStatefulWidget
class _DashboardSettingsScreenState extends State<DashboardSettingsScreen> {
  late bool _displayLeisure;
  late int _tasksCount;

  final TextEditingController _countTextEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initial value, if present
    _loadSharedPreferences();
    _countTextEditingController.text = "$_tasksCount";
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWithoutBottomNavbarBaseTemplate(
      titleBar: const GoBackTitleBar(
        title: "Dashboard",
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
        children: [
          Text(
            "Hinweis:",
            style: Theme.of(context).textTheme.textStyle2.withBold,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Damit die Änderungen an diesen Einstellungen wirksam werden, muss die App neu gestartet werden",
            style: Theme.of(context).textTheme.settingsInfoTextStyle,
          ),
          spacer,
          NumberInputField(
            hintText: "Anzahl eingeben",
            label: "Anzahl der eingeblendeten Aufgaben",
            iconData: Icons.task_alt_outlined,
            textEditingController: _countTextEditingController,
            onChange: (String? newCount) {
              _tasksCount = int.tryParse(
                      newCount == null
                          ? ""
                          : newCount.replaceAll(RegExp('[^0-9]'), ''),
                      radix: 10) ??
                  defaultTaskCountOnDashboard;

              _saveTaskCountOnDashboard();
            },
          ),
          SettingsGroup(
            title: "Ausgleich des Tages anzeigen",
            subTitle: "Alternativ kannst du mehr Aufgaben einblenden",
            iconData: Icons.local_florist_outlined,
            action: Switch(
              value: _displayLeisure,
              onChanged: (value) {
                setState(() {
                  _displayLeisure = !_displayLeisure;
                  _saveDisplayLeisure();
                });
              },
              activeColor: Theme.of(context).colorScheme.primary,
              inactiveThumbColor: Theme.of(context).colorScheme.cardColor,
              inactiveTrackColor:
                  Theme.of(context).colorScheme.onBackgroundSoft,
            ),
          ),
        ],
      ),
    );
  }

  void _saveDisplayLeisure() async {
    await SharedPreferencesData.storeDisplayLeisureOnDashboard(_displayLeisure);
  }

  void _saveTaskCountOnDashboard() async {
    await SharedPreferencesData.storeTaskCountOnDashboard(_tasksCount);
  }

  void _loadSharedPreferences() {
    setState(() {
      _tasksCount = SharedPreferencesData.taskCountOnDashboard ??
          defaultTaskCountOnDashboard;
      _displayLeisure = SharedPreferencesData.displayLeisureOnDashboard ??
          defaultDisplayLeisureOnDashboard;
    });
  }
}
