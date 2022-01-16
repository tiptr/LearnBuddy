import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/keywords/bloc/keywords_cubit.dart';
import 'package:learning_app/features/keywords/dtos/create_key_word_dto.dart';
import 'package:learning_app/util/logger.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/constants/theme_color_constants.dart';

class KeyWordAddDialog extends StatefulWidget {
  const KeyWordAddDialog({Key? key}) : super(key: key);

  @override
  State<KeyWordAddDialog> createState() => _KeyWordAddDialogState();
}

class _KeyWordAddDialogState extends State<KeyWordAddDialog> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Neues Schlagwort",
        style: Theme.of(context)
            .textTheme
            .textStyle1
            .withBold
            .withOnBackgroundHard,
      ),
      backgroundColor: Theme.of(context).colorScheme.cardColor,
      scrollable: false,
      content: Scrollbar(
        isAlwaysShown: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10.0),
                width: 250,
                child: TextField(
                  // Use subtitle1 here, to match the inputfield Styles from the
                  // native components (DatePicker,ColorPicker-hex-field)
                  style: Theme.of(context).textTheme.subtitle1,
                  decoration: InputDecoration(
                      hintText: "Bezeichnung eingeben",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .withOnBackgroundSoft),
                  controller: _textController,
                  autofocus: true,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        // Action Buttons
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MaterialButton(
              child: Text("Abbrechen",
                  style: Theme.of(context)
                      .textTheme
                      .textStyle3
                      .withOnBackgroundSoft),
              onPressed: () {
                logger.d("Abbruch beim Erstellen einer Kategorie");
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              child: Text(
                "Hinzufügen",
                style: Theme.of(context).textTheme.textStyle3.withPrimary,
              ),
              onPressed: () {
                logger.d(
                  "Schlagwort ${_textController.value.text} hinzufügen",
                );

                var createKeyWordDto = CreateKeyWordDto(
                  name: _textController.value.text,
                );

                BlocProvider.of<KeyWordsCubit>(context)
                    .createKeyWord(createKeyWordDto);

                // Close dialog
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ],
    );
  }
}
