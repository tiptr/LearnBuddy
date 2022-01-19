import 'package:flutter/material.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/shared/open_confirm_dialog.dart';

Future<bool> taskDeleteConfirmDialog({
  required BuildContext context,
  required String title
}) {
  return openConfirmDialog(
    context: context,
    title: "Aufgabe löschen?",
    content: RichText(
      text: TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: Theme.of(context).textTheme.textStyle2,
        children: <TextSpan>[
          const TextSpan(text: 'Willst du die Aufgabe '),
          TextSpan(
            text: title,
            style: Theme.of(context)
                .textTheme
                .textStyle2
                .withBold
                .withOnBackgroundHard,
          ),
          const TextSpan(text: ' wirklich löschen?'),
        ],
      ),
    ),
  );
}