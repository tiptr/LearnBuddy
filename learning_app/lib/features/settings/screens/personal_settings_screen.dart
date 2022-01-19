import 'package:flutter/material.dart';
import 'package:learning_app/shared/shared_preferences_data.dart';
import 'package:learning_app/shared/widgets/go_back_title_bar.dart';
import 'package:learning_app/shared/widgets/inputfields/number_input_field.dart';
import 'package:learning_app/shared/widgets/inputfields/text_input_field.dart';
import 'package:learning_app/shared/widgets/screen_without_bottom_navbar_base_template.dart';
import 'package:learning_app/constants/theme_font_constants.dart';

class PersonalSettingsScreen extends StatefulWidget {
  const PersonalSettingsScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<PersonalSettingsScreen> createState() => _PersonalSettingsScreenState();
}

class _PersonalSettingsScreenState extends State<PersonalSettingsScreen> {
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _ageTextEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initial value, if present
    _loadSharedPreferences();
    _nameTextEditingController.text = _name ?? '';
    _ageTextEditingController.text = _ageStringRep(_age);
  }

  int? _age;
  String? _name;

  @override
  Widget build(BuildContext context) {
    // Set initial dueDate:

    return ScreenWithoutBottomNavbarBaseTemplate(
      titleBar: const GoBackTitleBar(
        title: "Persönliche Informationen",
      ),
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
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextInputField(
            onChange: (String? newName) {
              _name = newName;
              _saveUserName();
            },
            preselectedText: _name ?? "",
            label: "Name",
            hintText: "Name eingeben",
          ),
          const SizedBox(
            height: 20.0,
          ),
          NumberInputField(
            onChange: (String? newAge) {
              _age = int.tryParse(newAge ?? "", radix: 10) ?? -1;
              _saveUserAge();
            },
            textEditingController: _ageTextEditingController,
            label: "Alter",
            hintText: "Alter eingeben",
          ),
        ],
      ),
    );
  }

  void _loadSharedPreferences() {
    setState(() {
      _age = SharedPreferencesData.userAge;
      _name = SharedPreferencesData.userName;
      _nameTextEditingController.text = _name ?? "";
      _ageTextEditingController.text = _ageStringRep(_age);
    });
  }

  void _saveUserName() async {
    await SharedPreferencesData.storeUserName(_name);
  }

  void _saveUserAge() async {
    await SharedPreferencesData.storeUserAge(_age);
  }

  String _ageStringRep(int? age) =>
      age == null || age < 0 ? "" : _age.toString();
}
