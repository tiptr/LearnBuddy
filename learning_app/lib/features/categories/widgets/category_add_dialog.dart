import 'package:flutter/material.dart';
import 'package:learning_app/features/categories/constants/available_colors.dart';
import 'package:learning_app/util/logger.dart';

import 'category_color_circle.dart';

class CategoryAddDialog extends StatefulWidget {
  const CategoryAddDialog({Key? key}) : super(key: key);

  @override
  State<CategoryAddDialog> createState() => _CategoryAddDialogState();
}

class _CategoryAddDialogState extends State<CategoryAddDialog> {
  Color selectedColor = Colors.grey;
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Neue Kategorie"),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title Entry
          Row(
            children: [
              Container(
                width: 10.0,
                height: 30.0,
                decoration: BoxDecoration(
                  color: selectedColor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: "Bezeichnung eingeben",
                  ),
                  controller: _textController,
                ),
              ),
            ],
          ),

          // Available colors
          SizedBox(
            width: 250,
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
                      onTap: (Color color) {
                        setState(() {
                          selectedColor = color;
                        });
                      },
                    ),
                  );
                })
              ],
            ),
          )
        ],
      ),
      actions: <Widget>[
        MaterialButton(
          elevation: 5.0,
          child: const Text("Abbrechen", style: TextStyle(color: Colors.grey)),
          onPressed: () {
            logger.d("Abbruch beim Erstellen einer Kategorie");
            Navigator.of(context).pop();
          },
        ),
        MaterialButton(
          elevation: 5.0,
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
