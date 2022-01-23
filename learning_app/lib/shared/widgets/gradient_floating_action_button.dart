import 'package:flutter/material.dart';
import 'package:learning_app/constants/theme_color_constants.dart';

FloatingActionButton gradientFloatingActionButton(
    {Object? heroTag,
    VoidCallback? onPressed,
    IconData? iconData,
    BuildContext? context}) {
  return FloatingActionButton(
    heroTag: heroTag,
    onPressed: onPressed,
    child: Container(
        height: 60,
        width: 60,
        child: Icon(
          iconData,
          color: Theme.of(context!).colorScheme.onPrimary,
        ),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: Theme.of(context).colorScheme.primaryGradient)),
  );
}
