import 'package:flutter/material.dart';
import 'package:learning_app/features/tags/models/tag.dart';

const double iconSize = 18.0;

class TagCard extends StatelessWidget {
  final Tag _tag;

  const TagCard({Key? key, required Tag task})
      : _tag = task,
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
              child: Chip(
                backgroundColor: Color(_tag.color).withOpacity(0.3),
                label: Row(
                  children: [const Spacer(), Text(_tag.name), const Spacer()],
                ),
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(_tag.color),
                ),
              ),
            ),
            Expanded(
              flex: 30,
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
              flex: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.palette_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 20.0),
                  Icon(
                    Icons.delete_outlined,
                    color: Theme.of(context).colorScheme.primary,
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
