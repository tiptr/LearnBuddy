import 'package:flutter/material.dart';
import 'package:learning_app/features/categories/constants/colors.dart';
import 'package:learning_app/features/categories/widgets/color_add_icon.dart';
import 'package:learning_app/util/logger.dart';

import 'category_color_circle.dart';

class CategoryAddDialog extends StatefulWidget {
  const CategoryAddDialog({Key? key}) : super(key: key);

  @override
  State<CategoryAddDialog> createState() => _CategoryAddDialogState();
}

class _CategoryAddDialogState extends State<CategoryAddDialog> {
  Color selectedColor = defaultColor;
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Neue Kategorie"),
      scrollable: true,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title Entry
          Row(
            children: [
              const Spacer(),
              Container(
                width: 10.0,
                height: 30.0,
                decoration: BoxDecoration(
                  color: selectedColor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10.0),
                width: 150.0,
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: "Bezeichnung eingeben",
                  ),
                  controller: _textController,
                ),
              ),
              const Spacer()
            ],
          ),

          const SizedBox(height: 50.0),

          // Available colors
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            height: 250,
            // TODO: Try to use a scrollable container like a ListView here
            //       Problem was the flex wrap until now, but there has to be a way.
            child: Wrap(
              children: [
                ...availableColors.map((Color color) {
                  return Container(
                    margin: const EdgeInsets.all(5.0),
                    child: CategoryColorCirlce(
                      radius: 20.0,
                      color: color,
                      selected: selectedColor == color,
                      onTap: (Color color) {
                        setState(() {
                          selectedColor = color;
                        });
                      },
                    ),
                  );
                }),
                ColorAddIcon(onPressed: () {
                  logger.d("On Add New Color For Category Pressed");
                })
              ],
            ),
          ),
        ],
      ),
      actions: <Widget>[
        MaterialButton(
          child: const Text("Abbrechen", style: TextStyle(color: Colors.grey)),
          onPressed: () {
            logger.d("Abbruch beim Erstellen einer Kategorie");
            Navigator.of(context).pop();
          },
        ),
        MaterialButton(
          child: Text(
            "Kategorie hinzufügen",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          onPressed: () {
            logger.d(
              "Kategorie hinzufügen mit ${_textController.value.text} und Farbe ${selectedColor.toString()}",
            );
          },
        )
      ],
    );
  }
}
