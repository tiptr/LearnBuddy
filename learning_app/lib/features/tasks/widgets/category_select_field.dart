import 'package:flutter/material.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/features/categories/dtos/read_category_dto.dart';

import 'category_select_item.dart';

class CategorySelectField extends StatefulWidget {
  final Function onSelect;
  final int? preselectedCategoryId;
  final List<ReadCategoryDto> options;

  const CategorySelectField({
    Key? key,
    required this.onSelect,
    required this.preselectedCategoryId,
    required this.options,
  }) : super(key: key);

  @override
  State<CategorySelectField> createState() => _CategorySelectFieldState();
}

class _CategorySelectFieldState extends State<CategorySelectField> {
  ReadCategoryDto? category;

  @override
  void initState() {
    super.initState();

    if (widget.preselectedCategoryId != null) {
      category = widget.options[widget.preselectedCategoryId!];
    }
  }

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onBackground,
            width: 2.0,
          ),
        ),
        contentPadding: const EdgeInsets.fromLTRB(0, 5.0, 5.0, 5.0),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2.0,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        filled: false,
        prefixIcon: Icon(
          Icons.category_outlined,
          color: Theme.of(context).colorScheme.onBackground,
        ),
        suffixIcon: category != null
            ? IconButton(
                icon: Icon(
                  Icons.close,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                onPressed: () {
                  // Change the state, so the widget will re-render
                  setState(() {
                    category = null;
                  });
                  // Notify Listener:
                  widget.onSelect(category?.id);
                },
              )
            : null,
        label: Text(
          "Kategorie",
          style: Theme.of(context).textTheme.textStyle2.withBold,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          value: category,
          hint: Text(
            "Kategorie ausw??hlen",
            style: Theme.of(context).textTheme.textStyle2.withOnBackgroundSoft,
          ),
          items: widget.options.map<DropdownMenuItem<ReadCategoryDto>>(
              (ReadCategoryDto category) {
            return DropdownMenuItem<ReadCategoryDto>(
              value: category,
              child: CategorySelectItem(category: category),
            );
          }).toList(),
          onChanged: (ReadCategoryDto? newValue) {
            setState(() {
              category = newValue!;
            });
            widget.onSelect(newValue?.id);
          },
        ),
      ),
    );
  }
}
