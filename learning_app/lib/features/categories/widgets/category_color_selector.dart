import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:learning_app/features/categories/constants/colors.dart';

class CategoryColorSelector extends StatelessWidget {
  final Function onColorSelect;
  final Color selectedColor;

  const CategoryColorSelector({
    Key? key,
    required this.selectedColor,
    required this.onColorSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlockPicker(
      pickerColor: selectedColor,
      onColorChanged: (Color color) {
        onColorSelect(color);
      },
      availableColors: availableColors,
      itemBuilder: pickerItemBuilder,
      layoutBuilder: pickerLayoutBuilder,
    );
  }
}

double _circlePadding = 8;
double _borderRadius = 20;
double _blurRadius = 5;
double _iconSize = 24;

Widget pickerLayoutBuilder(
  BuildContext context,
  List<Color> colors,
  PickerItem child,
) {
  return SizedBox(
    width: 300,
    height: 175,
    child: GridView.count(
      crossAxisCount: 5,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      children: [for (Color color in colors) child(color)],
      physics: const NeverScrollableScrollPhysics(),
    ),
  );
}

Widget pickerItemBuilder(
    Color color, bool isCurrentColor, void Function() changeColor) {
  return Container(
    margin: EdgeInsets.all(_circlePadding),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(_borderRadius),
      color: color,
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.8),
          offset: const Offset(1, 2),
          blurRadius: _blurRadius,
        )
      ],
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: changeColor,
        borderRadius: BorderRadius.circular(_borderRadius),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 250),
          opacity: isCurrentColor ? 1 : 0,
          child: Icon(
            Icons.done,
            size: _iconSize,
            color: useWhiteForeground(color) ? Colors.white : Colors.black,
          ),
        ),
      ),
    ),
  );
}
