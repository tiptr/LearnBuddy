import 'package:flutter/material.dart';
import 'package:learning_app/features/categories/models/category.dart';
import 'package:learning_app/features/categories/widgets/category_app_bar.dart';
import 'package:learning_app/features/categories/widgets/category_card.dart';
import 'package:learning_app/util/logger.dart';

class CategoryOverviewScreen extends StatelessWidget {
  final categories = <Category>[
    Category(id: 1, name: "Geschichte", color: Colors.red.value),
    Category(id: 2, name: "Hausaufgabe", color: Colors.blue.value),
    Category(id: 3, name: "Mathe", color: Colors.orange.value),
    Category(id: 4, name: "Physik", color: Colors.lightBlue.value),
    Category(id: 5, name: "Englisch", color: Colors.grey.value),
    Category(id: 6, name: "Lernen", color: Colors.purple.value),
  ];

  CategoryOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CategoryAddAppBar(),
      body: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: categories.length,
        itemBuilder: (BuildContext ctx, int idx) =>
            CategoryCard(category: categories[idx]),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "NavigateToCategoryAddScreen",
        onPressed: () {
          logger.d("TODO: Open tag creation page");
        },
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
