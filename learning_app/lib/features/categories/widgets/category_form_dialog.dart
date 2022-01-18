import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/categories/bloc/categories_cubit.dart';
import 'package:learning_app/features/categories/dtos/create_category_dto.dart';
import 'package:learning_app/features/categories/constants/selection_colors.dart';
import 'package:learning_app/features/categories/dtos/read_category_dto.dart';
import 'package:learning_app/features/categories/dtos/update_category_dto.dart';
import 'package:learning_app/features/categories/widgets/category_color_selector.dart';
import 'package:learning_app/shared/widgets/color_indicator.dart';
import 'package:learning_app/util/logger.dart';

class CategoryFormDialog extends StatefulWidget {
  final ReadCategoryDto? existingCategory;

  /// This widget is a form to create and update
  /// categories. When no existingCateogry is passed,
  /// a new category is created, otherwise, the
  /// existing category gets updated.
  const CategoryFormDialog({
    Key? key,
    required this.existingCategory,
  }) : super(key: key);

  @override
  State<CategoryFormDialog> createState() => _CategoryFormDialogState();
}

class _CategoryFormDialogState extends State<CategoryFormDialog> {
  late Color selectedColor;
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.existingCategory == null) {
      selectedColor = preSelectedColorForSelection;
    } else {
      var category = widget.existingCategory!;
      selectedColor = category.color;
      _textController.value = TextEditingValue(text: category.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Row(
            children: [
              widget.existingCategory == null
                  ? const Text("Neue Kategorie")
                  : const Text("Kategorie bearbeiten"),
            ],
          ),
          // Spacer
          const SizedBox(height: 20.0),
          // Title Entry
          Row(
            children: [
              const Spacer(),
              ColorIndicator(color: selectedColor, height: 30.0, width: 10.0),
              Container(
                margin: const EdgeInsets.only(left: 10.0),
                width: 150.0,
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: "Bezeichnung eingeben",
                  ),
                  controller: _textController,
                  autofocus: true,
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
                  ),
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
                logger.d("Abbruch beim Speichern einer Kategorie");
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
                  "Kategorie mit ${_textController.value.text} und Farbe ${selectedColor.toString()}",
                );

                if (widget.existingCategory == null) {
                  // Create new category
                  var createCategoryDto = CreateCategoryDto(
                    name: _textController.value.text,
                    color: selectedColor,
                  );

                  BlocProvider.of<CategoriesCubit>(context)
                      .createCategory(createCategoryDto);
                } else {
                  // Edit existing category
                  var oldCategory = widget.existingCategory!;

                  var updateCategoryDto = UpdateCategoryDto(
                    id: oldCategory.id,
                    name: _textController.value.text,
                    color: selectedColor,
                  );

                  BlocProvider.of<CategoriesCubit>(context)
                      .updateCategory(updateCategoryDto);
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
