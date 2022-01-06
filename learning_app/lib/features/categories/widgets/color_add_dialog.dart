import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:learning_app/features/categories/constants/colors.dart';

class ColorAddDialog extends StatefulWidget {
  const ColorAddDialog({Key? key}) : super(key: key);

  @override
  State<ColorAddDialog> createState() => _ColorAddDialogState();
}

class _ColorAddDialogState extends State<ColorAddDialog> {
  Color selectedColor = preSelectedColorForSelection;

  void onColorChanged(Color color) {
    setState(() {
      selectedColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(500),
          bottom: Radius.circular(15.0),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            HueRingPicker(
              pickerColor: selectedColor,
              onColorChanged: (Color color) {
                onColorChanged(color);
              },
              portraitOnly: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  child: const Text(
                    "Abbrechen",
                    style: TextStyle(color: Colors.grey),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(null);
                  },
                ),
                MaterialButton(
                  child: Text(
                    "Hinzufügen",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(selectedColor);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
