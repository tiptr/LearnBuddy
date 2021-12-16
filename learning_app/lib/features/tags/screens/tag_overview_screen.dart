import 'package:flutter/material.dart';
import 'package:learning_app/features/tags/models/tag.dart';
import 'package:learning_app/features/tags/widgets/tag_app_bar.dart';
import 'package:learning_app/features/tags/widgets/tag_card.dart';

class TagOverviewScreen extends StatelessWidget {
  final tags = <Tag>[
    Tag(id: 1, name: "Geschichte", color: Colors.red.value),
    Tag(id: 2, name: "Hausaufgabe", color: Colors.blue.value),
    Tag(id: 3, name: "Mathe", color: Colors.orange.value),
    Tag(id: 4, name: "Physik", color: Colors.lightBlue.value),
    Tag(id: 5, name: "Englisch", color: Colors.grey.value),
    Tag(id: 6, name: "Lernen", color: Colors.purple.value),
  ];

  TagOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TagAddAppBar(),
      body: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: tags.length,
        itemBuilder: (BuildContext ctx, int idx) => TagCard(task: tags[idx]),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "NavigateToTagAddScreen",
        onPressed: () {
          print("TODO: Open tag creation page");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
