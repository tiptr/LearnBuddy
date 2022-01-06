import 'package:flutter/material.dart';
import 'package:learning_app/features/categories/constants/colors.dart';
import 'package:learning_app/features/categories/widgets/category_color_selector.dart';
import 'package:learning_app/util/logger.dart';

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
      title: Column(
        children: [
          Row(
            children: const [
              Text("Neue Kategorie"),
            ],
          ),
          // Spacer
          const SizedBox(height: 20.0),
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
        ],
      ),
      scrollable: false,
      content: Scrollbar(
        isAlwaysShown: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Spacer
              const SizedBox(height: 10.0),
              // Color Selection
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    // height: 100,
                    child: CategoryColorSelector(
                      onColorSelect: (Color color) {
                        setState(() {
                          selectedColor = color;
                        });
                      },
                      selectedColor: selectedColor,
                    )),
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
                  "Kategorie hinzufügen mit ${_textController.value.text} und Farbe ${selectedColor.toString()}",
                );
              },
            )
          ],
        ),
      ],
    );
  }
}
