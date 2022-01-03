import 'package:flutter/material.dart';

class ColorAddIcon extends StatelessWidget {
  final Function onPressed;

  const ColorAddIcon({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      width: 40.0,
      height: 40.0,
      child: Align(
        alignment: Alignment.center,
        child: IconButton(
          padding: const EdgeInsets.all(0),
          icon: Icon(
            Icons.add,
            size: 40,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: onPressed(),
        ),
      ),
    );
  }
}
