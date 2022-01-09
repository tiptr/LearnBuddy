import 'package:flutter/material.dart';
import 'package:learning_app/shared/widgets/base_layout.dart';
import 'package:learning_app/shared/widgets/base_title_bar.dart';

class LearningAidsScreen extends StatelessWidget {
  const LearningAidsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      titleBar: BaseTitleBar(
        title: "Lernhilfen",
      ),
      content: Text("Page LearningAids not implemented yet"),
    );
  }
}
