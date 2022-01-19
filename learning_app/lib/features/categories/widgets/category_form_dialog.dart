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
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/constants/theme_color_constants.dart';

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
      backgroundColor: Theme.of(context).colorScheme.cardColor,
      title: Column(
        children: [
          Row(
            children: [
              Text(
                widget.existingCategory == null
                    ? "Neue Kategorie"
                    : "Kategorie bearbeiten",
                style: Theme.of(context)
                    .textTheme
                    .textStyle2
                    .withBold
                    .withOnBackgroundHard,
              ),
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
                width: 200,
                child: TextField(
                  // Use subtitle1 here, to match the inputfield Styles from the
                  // native components (DatePicker,ColorPicker-hex-field)
                  style: Theme.of(context).textTheme.subtitle1,
                  decoration: InputDecoration(
                    hintText: "Bezeichnung eingeben",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .withOnBackgroundSoft,
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
              child: Text("Abbrechen",
                  style: Theme.of(context)
                      .textTheme
                      .textStyle3
                      .withOnBackgroundSoft),
              onPressed: () {
                logger.d("Abbruch beim Speichern einer Kategorie");
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              child: Text(
                "Speichern",
                style: Theme.of(context).textTheme.textStyle3.withPrimary,
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

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Kategorie erfolgreich gespeichert!',
                      style: Theme.of(context).textTheme.textStyle2.withSucess,
                    ),
                    backgroundColor:
                        Theme.of(context).colorScheme.subtleBackgroundGrey,
                  ),
                );
              },
            )
          ],
        ),
      ],
    );
  }
}
