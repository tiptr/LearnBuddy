import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/categories/bloc/categories_cubit.dart';
import 'package:learning_app/features/categories/dtos/read_category_dto.dart';
import 'package:learning_app/features/categories/widgets/category_form_dialog.dart';
import 'package:learning_app/shared/widgets/color_indicator.dart';
import 'package:learning_app/shared/open_confirm_dialog.dart';

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
      color: Colors.white,
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
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            // Excluded from MVP
            // Expanded(
            //   flex: 15,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: const [
            //       SizedBox(width: 10.0),
            //       Text(
            //         "9",
            //         style: TextStyle(
            //           color: Colors.grey,
            //           fontWeight: FontWeight.bold,
            //           overflow: TextOverflow.ellipsis,
            //         ),
            //       ),
            //       SizedBox(width: 5.0),
            //       Icon(
            //         Icons.task_outlined,
            //         color: Colors.grey,
            //       ),
            //     ],
            //   ),
            // ),
            Expanded(
              flex: 35,
              child: Row(
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
                    icon: Icon(
                      Icons.create_outlined,
                      color: Theme.of(context).colorScheme.secondary,
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
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              const TextSpan(text: 'Willst du die Kategorie '),
                              TextSpan(
                                text: category.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const TextSpan(text: ' wirklich löschen?'),
                            ],
                          ),
                        ),
                      );

                      if (confirmed) {
                        BlocProvider.of<CategoriesCubit>(context)
                            .deleteCategoryById(category.id);
                      }
                    },
                    icon: Icon(
                      Icons.delete_outlined,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
