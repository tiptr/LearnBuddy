import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/keywords/bloc/keywords_cubit.dart';
import 'package:learning_app/features/keywords/dtos/create_key_word_dto.dart';
import 'package:learning_app/util/logger.dart';

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
      title: const Text("Neues Schlagwort"),
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
                  decoration: const InputDecoration(
                    hintText: "Bezeichnung eingeben",
                  ),
                  controller: _textController,
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
              child:
                  const Text("Abbrechen", style: TextStyle(color: Colors.grey)),
              onPressed: () {
                logger.d("Abbruch beim Erstellen einer Kategorie");
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              child: Text(
                "Hinzufügen",
                style: TextStyle(color: Theme.of(context).primaryColor),
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
