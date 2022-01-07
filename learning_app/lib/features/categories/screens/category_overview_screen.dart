import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/categories/bloc/categories_cubit.dart';
import 'package:learning_app/features/categories/bloc/categories_state.dart';
import 'package:learning_app/features/categories/models/category.dart';
import 'package:learning_app/features/categories/widgets/category_add_dialog.dart';
import 'package:learning_app/features/categories/widgets/category_app_bar.dart';
import 'package:learning_app/features/categories/widgets/category_card.dart';

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

        return StreamBuilder<List<Category>>(
          stream: state.categoriesStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'Du hast aktuell keine Kategorien.\nDrücke auf Plus, um eine Kategorie anzulegen',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF636573),
                  ),
                ),
              );
            }

            final categories = snapshot.data!;

            return Scaffold(
              appBar: const CategoryAddAppBar(),
              body: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: categories.length,
                itemBuilder: (BuildContext ctx, int idx) => CategoryCard(
                  category: categories[idx],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                heroTag: "NavigateToCategoryAddScreen",
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const CategoryAddDialog();
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
