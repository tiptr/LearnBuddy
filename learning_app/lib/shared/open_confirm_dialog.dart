import 'package:flutter/material.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/constants/theme_color_constants.dart';

/// Opens a confirm dialog with variable title and content and
/// returns true if confirmed and false otherwise.
Future<bool> openConfirmDialog({
  required BuildContext context,
  required String title,
  required Widget content,
}) async {
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      title,
      style:
          Theme.of(context).textTheme.textStyle1.withBold.withOnBackgroundHard,
    ),
    contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 5.0),
    backgroundColor: Theme.of(context).colorScheme.cardColor,
    content: SingleChildScrollView(
      child: Column(
        children: [
          // Content of the dialog
          content,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  MaterialButton(
                    child: Text("Abbrechen",
                        style: Theme.of(context)
                            .textTheme
                            .textStyle2
                            .withOnBackgroundSoft),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  MaterialButton(
                    child: Text("Bestätigen",
                        style:
                            Theme.of(context).textTheme.textStyle2.withPrimary),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  )
                ],
              )
            ],
          ),
        ],
      ),
    ),
  );
  // show the dialog
  var response = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );

  return response ?? false;
}
