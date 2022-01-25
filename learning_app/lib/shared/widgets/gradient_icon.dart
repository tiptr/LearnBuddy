import 'package:flutter/material.dart';
import 'package:learning_app/constants/theme_color_constants.dart';

ShaderMask gradientIcon(
    {required IconData iconData,
    required BuildContext context,
    LinearGradient? gradient,
    double size = 24.0}) {
  gradient ??= Theme.of(context).colorScheme.primaryGradient;
  return ShaderMask(
    child: SizedBox(
      width: size,
      height: size,
      child: Icon(
        iconData,
        size: size,
        color: Colors.white,
      ),
    ),
    shaderCallback: (Rect bounds) {
      final Rect rect = Rect.fromLTRB(0, 0, size, size);
      return gradient!.createShader(rect);
    },
  );
}
