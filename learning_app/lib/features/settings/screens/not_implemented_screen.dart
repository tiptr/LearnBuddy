import 'package:flutter/material.dart';
import 'package:learning_app/features/settings/widgets/settings_group.dart';
import 'package:learning_app/shared/widgets/go_back_title_bar.dart';
import 'package:learning_app/features/categories/screens/category_overview_screen.dart';

class NotImplementedScreen extends StatelessWidget {
  const NotImplementedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set initial dueDate:

    return const Scaffold(
        appBar: GoBackTitleBar(
          title: "Nicht Implementiert",
        ),
        body: Center(child: Text("...kommt aber bald!")));
  }
}
