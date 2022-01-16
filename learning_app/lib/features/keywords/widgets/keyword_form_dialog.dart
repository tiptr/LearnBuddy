import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/keywords/bloc/keywords_cubit.dart';
import 'package:learning_app/features/keywords/dtos/create_key_word_dto.dart';
import 'package:learning_app/features/keywords/dtos/read_key_word_dto.dart';
import 'package:learning_app/features/keywords/dtos/update_key_word_dto.dart';
import 'package:learning_app/util/logger.dart';

class KeyWordFormDialog extends StatefulWidget {
  final ReadKeyWordDto? existingKeyword;

  /// This widget is a form to create and update
  /// keywords. When no existingKeyword is passed,
  /// a new keyword is created, otherwise, the
  /// existing keyword gets updated.
  const KeyWordFormDialog({Key? key, required this.existingKeyword})
      : super(key: key);

  @override
  State<KeyWordFormDialog> createState() => _KeyWordFormDialogState();
}

class _KeyWordFormDialogState extends State<KeyWordFormDialog> {
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.existingKeyword != null) {
      var keyword = widget.existingKeyword!;
      _textController.value = TextEditingValue(text: keyword.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.existingKeyword == null
          ? const Text("Neues Schlagwort")
          : const Text("Schlagwort bearbeiten"),
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
                logger.d("Abbruch beim Speichern eines Schlagworts");
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              child: Text(
                "Speichern",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onPressed: () {
                logger.d(
                  "Schlagwort ${_textController.value.text} hinzufügen",
                );

                if (widget.existingKeyword == null) {
                  // Create new keyword
                  var createKeyWordDto = CreateKeyWordDto(
                    name: _textController.value.text,
                  );

                  BlocProvider.of<KeyWordsCubit>(context)
                      .createKeyWord(createKeyWordDto);
                } else {
                  // Edit existing keyword
                  var oldKeyWord = widget.existingKeyword!;

                  var updateKeyWordDto = UpdateKeyWordDto(
                    id: oldKeyWord.id,
                    name: _textController.value.text,
                  );

                  BlocProvider.of<KeyWordsCubit>(context)
                      .updateKeyWord(updateKeyWordDto);
                }

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
