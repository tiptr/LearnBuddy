import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/categories/bloc/categories_cubit.dart';
import 'package:learning_app/features/categories/bloc/categories_state.dart';
import 'package:learning_app/features/categories/dtos/read_category_dto.dart';
import 'package:learning_app/features/categories/widgets/category_form_dialog.dart';
import 'package:learning_app/features/categories/widgets/category_card.dart';
import 'package:learning_app/shared/widgets/go_back_title_bar.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/shared/widgets/screen_without_bottom_navbar_base_template.dart';

class CategoryOverviewScreen extends StatelessWidget {
  const CategoryOverviewScreen({Key? key}) : super(key: key);

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
            late Widget body;
            if (snapshot.connectionState == ConnectionState.waiting) {
              body = const Center(child: CircularProgressIndicator());
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              body = Center(
                child: Text(
                    'Du hast aktuell keine Kategorien.\nDrücke auf das Plus, um eine Kategorie anzulegen',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.textStyle4),
              );
            } else {
              final categories = snapshot.data!;
              body = ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: categories.length,
                itemBuilder: (BuildContext ctx, int idx) => CategoryCard(
                  category: categories[idx],
                ),
              );
            }

            return ScreenWithoutBottomNavbarBaseTemplate(
              titleBar: const GoBackTitleBar(title: "Kategorien"),
              body: body,
              fab: FloatingActionButton(
                heroTag: "NavigateToCategoryAddScreen",
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const CategoryFormDialog(
                        existingCategory: null,
                      );
                    },
                  );
                },
                child: const Icon(Icons.add),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            );
          },
        );
      },
    );
  }
}
