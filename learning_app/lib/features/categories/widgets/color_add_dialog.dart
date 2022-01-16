import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:learning_app/constants/basic_card.dart';
import 'package:learning_app/features/categories/constants/selection_colors.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/constants/theme_color_constants.dart';

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
      backgroundColor: Theme.of(context).colorScheme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: const Radius.circular(500),
          bottom: Radius.circular(BasicCard.borderRadius),
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
                  child: Text(
                    "Abbrechen",
                    style: Theme.of(context)
                        .textTheme
                        .textStyle3
                        .withOnBackgroundSoft,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(null);
                  },
                ),
                MaterialButton(
                  child: Text(
                    "Hinzufügen",
                    style: Theme.of(context).textTheme.textStyle3.withPrimary,
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
