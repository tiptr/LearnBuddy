import 'package:flutter/material.dart';
import 'package:learning_app/features/categories/models/category.dart';
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
              flex: 40,
              child: Row(
                children: [
                  Container(
                    width: 10.0,
                    height: 30.0,
                    margin: const EdgeInsets.only(right: 15.0),
                    decoration: BoxDecoration(
                      color: _category.color,
                      borderRadius: BorderRadius.circular(5.0),
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
              flex: 15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  SizedBox(width: 10.0),
                  Text(
                    "9",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 5.0),
                  Icon(
                    Icons.task_outlined,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 45,
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
                    onPressed: () {
                      logger.d("TODO: Handle delete click");
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
