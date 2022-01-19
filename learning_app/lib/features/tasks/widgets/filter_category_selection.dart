import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/features/categories/bloc/categories_cubit.dart';
import 'package:learning_app/features/categories/bloc/categories_state.dart';
import 'package:learning_app/features/categories/dtos/read_category_dto.dart';

class FilterCategorySelection extends StatelessWidget {
  final List<ReadCategoryDto> selected;
  final Function onTap;

  const FilterCategorySelection({
    Key? key,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  bool isSelected(ReadCategoryDto category) {
    return selected.contains(category);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        // This only checks for the success state, we might want to check for
        // errors in the future here.
        if (state is! CategoriesLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        return StreamBuilder<List<ReadCategoryDto>>(
          stream: state.categoriesStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            var categoryOptions = snapshot.data!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Kategorien",
                  style: Theme.of(context)
                      .textTheme
                      .textStyle1
                      .withOnBackgroundSoft,
                ),
                const SizedBox(height: 10.0),
                Wrap(
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  runAlignment: WrapAlignment.start,
                  runSpacing: 7.5,
                  spacing: 7.5,
                  children: categoryOptions
                      .map(
                        (c) => InkWell(
                          onTap: () {
                            onTap(c);
                          },
                          child: Chip(
                            label: Text(c.name),
                            backgroundColor: isSelected(c) ? c.color : null,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                      )
                      .toList(),
                )
              ],
            );
          },
        );
      },
    );
  }
}
