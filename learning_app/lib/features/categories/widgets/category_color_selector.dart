import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:learning_app/features/categories/constants/colors.dart';
import 'package:learning_app/features/categories/widgets/color_add_dialog.dart';
import 'package:learning_app/util/logger.dart';

class CategoryColorSelector extends StatefulWidget {
  final Function onColorSelect;
  final Color selectedColor;

  const CategoryColorSelector({
    Key? key,
    required this.selectedColor,
    required this.onColorSelect,
  }) : super(key: key);

  @override
  State<CategoryColorSelector> createState() => _CategoryColorSelectorState();
}

class _CategoryColorSelectorState extends State<CategoryColorSelector> {
  List<Color> selectableColors = availableColors;

  @override
  Widget build(BuildContext context) {
    return BlockPicker(
      pickerColor: widget.selectedColor,
      onColorChanged: (Color color) {
        widget.onColorSelect(color);
      },
      availableColors: selectableColors,
      itemBuilder: pickerItemBuilder,
      // LayoutBuilder needs to have the signature "BuildContext X List<Color> X PickerItem -> Widget".
      // Since we want to rerender the widget once a color is selected though, one solution is calling
      // setState on a stateful widget. By currying the layout builder function, we can pass a higher
      // order function, that causes a rerender.
      layoutBuilder: (
        BuildContext context,
        List<Color> colors,
        Widget Function(Color) child,
      ) =>
          pickerLayoutBuilder(
        context,
        colors,
        child,
        // Function that causes rerender and adds the new color to the color picker.
        (Color color) {
          setState(() {
            // Add the selected color
            selectableColors = [...selectableColors, color];
            // Preselect the new color:
            widget.onColorSelect(color);
          });
        },
      ),
    );
  }
}

double _circlePadding = 8;
double _borderRadius = 20;
double _blurRadius = 5;
double _iconSize = 24;

Widget pickerLayoutBuilder(BuildContext context, List<Color> colors,
    PickerItem child, Function onColorSelect) {
  return SizedBox(
    width: 300,
    // I can't figure out how to scale this dynamically,
    // keep getting a render exception.
    height: 300,
    child: GridView.count(
      crossAxisCount: 5,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      children: [
        for (Color color in colors) child(color),
        IconButton(
          padding: const EdgeInsets.all(0),
          onPressed: () async {
            // Open color picker
            Color? selectedColor = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return const ColorAddDialog();
              },
            );

            if (selectedColor != null) {
              logger.d("Found color $selectedColor, redrawing...");
              onColorSelect(selectedColor);
            }
          },
          icon: const Icon(Icons.add, size: 40),
          color: Theme.of(context).primaryColor,
        )
      ],
      physics: const NeverScrollableScrollPhysics(),
    ),
  );
}

Widget pickerItemBuilder(
  Color color,
  bool isCurrentColor,
  void Function() changeColor,
) {
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
