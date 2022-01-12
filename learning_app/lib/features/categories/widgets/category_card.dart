import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/categories/bloc/categories_cubit.dart';
import 'package:learning_app/features/categories/models/category.dart';
import 'package:learning_app/shared/widgets/color_indicator.dart';
import 'package:learning_app/shared/open_confirm_dialog.dart';
import 'package:learning_app/util/logger.dart';

const double iconSize = 18.0;

class CategoryCard extends StatelessWidget {
  final Category _category;

  const CategoryCard({Key? key, required Category category})
      : _category = category,
        super(key: key);

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
            Expanded(
              flex: 50,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 15.0),
                    child: ColorIndicator(
                      color: _category.color,
                      height: 30.0,
                      width: 10.0,
                    ),
                  ),
                  Text(
                    _category.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      logger.d("TODO: Handle palette click");
                    },
                    icon: Icon(
                      Icons.palette_outlined,
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
                                text: _category.name,
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
                            .deleteCategoryById(_category.id);
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
