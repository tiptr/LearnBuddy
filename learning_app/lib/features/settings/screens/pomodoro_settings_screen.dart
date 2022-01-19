import 'package:flutter/material.dart';
import 'package:learning_app/constants/settings_constants.dart';
import 'package:learning_app/constants/settings_spacer.dart';
import 'package:learning_app/constants/theme_color_constants.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/features/settings/widgets/settings_group.dart';
import 'package:learning_app/shared/shared_preferences_data.dart';
import 'package:learning_app/shared/widgets/go_back_title_bar.dart';
import 'package:learning_app/shared/widgets/inputfields/duration_input_field.dart';
import 'package:learning_app/shared/widgets/inputfields/number_input_field.dart';
import 'package:learning_app/shared/widgets/screen_without_bottom_navbar_base_template.dart';

class PomodoroSettingsScreen extends StatefulWidget {
  const PomodoroSettingsScreen({Key? key}) : super(key: key);

  @override
  State<PomodoroSettingsScreen> createState() => _PomodoroSettingsScreenState();
}

/// private State class that goes with MyStatefulWidget
class _PomodoroSettingsScreenState extends State<PomodoroSettingsScreen> {
  late Duration _concentrationMinutes;
  late Duration _shortBreakMinutes;
  late Duration _longBreakMinutes;
  late int _cycleCount;

  final TextEditingController _countTextEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initial value, if present
    _loadSharedPreferences();
    _countTextEditingController.text = _countStringRep(_cycleCount);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWithoutBottomNavbarBaseTemplate(
      titleBar: const GoBackTitleBar(
        title: "Pomodoro-Timer",
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
        children: [
          Text(
            "Bitte beachten:",
            style: Theme.of(context).textTheme.textStyle2.withBold,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Die Standardwerte spiegeln die Empfehlungen der Pomodoro-Technik wieder. Sie zielen auf ein ausgewogenes Verhältnis zwischen Lern- oder Arbeitsphasen und den Pausen ab.\nUnten erfährst du mehr über die Pomodoro-Technik\nEine Änderung der Werte kann diesen Effekt negativ beeinflussen.",
            style: Theme.of(context).textTheme.settingsInfoTextStyle,
          ),
          spacer,
          DurationInputField(
            label: "Dauer der Konzentrationsphasen",
            onChange: (Duration? d) {
              _concentrationMinutes =
                  d ?? const Duration(minutes: defaultTaskCountOnDashboard);

              _saveConcentrationMinutes();
            },
            preselectedDuration: _concentrationMinutes,
          ),
          spacer,
          DurationInputField(
            label: "Dauer der kurzen Pausenphasen",
            onChange: (Duration? d) {
              _shortBreakMinutes =
                  d ?? const Duration(minutes: defaultBreakMinutes);

              _saveShortBreakMinutes();
            },
            preselectedDuration: _shortBreakMinutes,
          ),
          spacer,
          DurationInputField(
            label: "Dauer der langen Pausenphasen",
            onChange: (Duration? d) {
              _longBreakMinutes =
                  d ?? const Duration(minutes: defaultLongerBreakMinutes);

              _saveLongBreakMinutes();
            },
            preselectedDuration: _concentrationMinutes,
          ),
          spacer,
          NumberInputField(
            hintText: "Anzahl eingeben",
            label: "Anzahl der Arbeitsphasen bis zu einer langen Pause",
            iconData: Icons.task_alt_outlined,
            textEditingController: _countTextEditingController,
            onChange: (String? newCount) {
              _cycleCount = int.tryParse(
                      newCount == null
                          ? ""
                          : newCount.replaceAll(RegExp('[^0-9]'), ''),
                      radix: 10) ??
                  defaultCountUntilLongerBreak;

              _saveCyvleCount();
            },
          ),
          spacer,
          SettingsGroup(
            title: "Nicht-Stören-Modus automatisch steuern",
            subTitle: "Aktiv während Konzentrationsphasen",
            iconData: Icons.do_not_disturb_alt_outlined,
            action: Switch(
              value: false,
              onChanged: (value) {
                setState(() {});
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

  String _countStringRep(int count) {
    return count == defaultCountUntilLongerBreak
        ? "$count (Standardwert)"
        : "$count";
  }

  void _saveConcentrationMinutes() async {
    // await SharedPreferencesData.storeDisplayLeisureOnPomodoro(_displayLeisure);
  }

  void _saveLongBreakMinutes() async {
    // await SharedPreferencesData.storeTaskCountOnPomodoro(_tasksCount);
  }
  void _saveShortBreakMinutes() async {
    // await SharedPreferencesData.storeDisplayLeisureOnPomodoro(_displayLeisure);
  }

  void _saveCyvleCount() async {
    // await SharedPreferencesData.storeTaskCountOnPomodoro(_tasksCount);
  }

  void _loadSharedPreferences() {
    setState(() {
      _concentrationMinutes = Duration(
          minutes: SharedPreferencesData.concentrationMinutes ??
              defaultConcentrationMinutes);
      _shortBreakMinutes = Duration(
          minutes: SharedPreferencesData.breakMinutes ?? defaultBreakMinutes);
      _longBreakMinutes = Duration(
          minutes: SharedPreferencesData.longerBreakMinutes ??
              defaultLongerBreakMinutes);
      _cycleCount = SharedPreferencesData.countUntilLongerBreak ??
          defaultCountUntilLongerBreak;
    });
  }
}
