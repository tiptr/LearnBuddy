import 'package:flutter/material.dart';

class LernhilfenScreen extends StatelessWidget {
  const LernhilfenScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 80.0,
        height: 50.0,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent),
          color: Colors.blue,
          shape: BoxShape.circle,
        ));
  }
}
