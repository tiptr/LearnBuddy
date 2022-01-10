import 'package:flutter/material.dart';

/// Opens a confirm dialog with variable title and content and
/// returns true if confirmed and false otherwise.
Future<bool> openConfirmDialog({
  required BuildContext context,
  required String title,
  required Widget content,
}) async {
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 5.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(12.5),
      ), // @MarcEngelmannTUM: Let's get it on!
    ),
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
                    child: const Text(
                      "Abbrechen",
                      style: TextStyle(color: Colors.grey),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  MaterialButton(
                    child: Text(
                      "Bestätigen",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
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
