import 'package:flutter/material.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/features/categories/dtos/read_category_dto.dart';
import 'package:learning_app/shared/widgets/color_indicator.dart';

class CategorySelectItem extends StatelessWidget {
  final ReadCategoryDto category;

  const CategorySelectItem({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10.0),
          child: ColorIndicator(
            color: category.color,
            height: 30.0,
            width: 10.0,
          ),
        ),
        Expanded(
          child: Text(
            category.name,
            style: Theme.of(context).textTheme.textStyle2.withOutBold,
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
