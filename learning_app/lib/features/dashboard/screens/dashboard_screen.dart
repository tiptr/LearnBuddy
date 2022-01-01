import 'package:flutter/material.dart';
import 'package:learning_app/features/categories/screens/category_overview_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Text("Page Dashboard not implemented yet"),
          // Only for navigation to tags
          const SizedBox(height: 40.0),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryOverviewScreen(),
              ),
            ),
            child: Ink(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: const Center(
                child: Text(
                  "Tag Overview",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );

    return const Text("Page Dashboard not implemented yet");
  }
}



