import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/categories/bloc/categories_cubit.dart';
import 'package:learning_app/features/categories/dtos/read_category_dto.dart';
import 'package:learning_app/features/categories/widgets/category_form_dialog.dart';
import 'package:learning_app/shared/widgets/color_indicator.dart';
import 'package:learning_app/shared/open_confirm_dialog.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/constants/theme_color_constants.dart';
import 'package:learning_app/shared/widgets/gradient_icon.dart';

const double iconSize = 18.0;

class CategoryCard extends StatelessWidget {
  final ReadCategoryDto category;

  const CategoryCard({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: _card(context),
    );
  }

  Widget _card(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Theme.of(context).colorScheme.cardColor,
      elevation: 10,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 15.0),
              child: ColorIndicator(
                color: category.color,
                height: 30.0,
                width: 10.0,
              ),
            ),
            Expanded(
              flex: 65,
              child: Text(
                category.name,
                style: Theme.of(context)
                    .textTheme
                    .textStyle4
                    .withBold
                    .withOnBackgroundHard,
                textAlign: TextAlign.start,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CategoryFormDialog(
                          existingCategory: category,
                        );
                      },
                    );
                  },
                  icon: gradientIcon(
                    iconData: Icons.create_outlined,
                    context: context,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    var confirmed = await openConfirmDialog(
                      context: context,
                      title: "Kategorie löschen?",
                      content: RichText(
                        text: TextSpan(
                          // Note: Styles for TextSpans must be explicitly defined.
                          // Child text spans will inherit styles from parent
                          style: Theme.of(context).textTheme.textStyle2,
                          children: <TextSpan>[
                            const TextSpan(text: 'Willst du die Kategorie '),
                            TextSpan(
                              text: category.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .textStyle2
                                  .withBold
                                  .withOnBackgroundHard,
                            ),
                            const TextSpan(text: ' wirklich löschen?'),
                          ],
                        ),
                      ),
                    );

                    if (confirmed) {
                      BlocProvider.of<CategoriesCubit>(context)
                          .deleteCategoryById(category.id);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Kategorie erfolgreich gelöscht!',
                            style: Theme.of(context)
                                .textTheme
                                .textStyle2
                                .withSucess,
                          ),
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .subtleBackgroundGrey,
                        ),
                      );
                    }
                  },
                  icon: gradientIcon(
                    iconData: Icons.delete_outlined,
                    context: context,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
