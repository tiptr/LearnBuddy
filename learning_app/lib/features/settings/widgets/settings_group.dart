import 'package:flutter/material.dart';
import 'package:learning_app/constants/theme_color_constants.dart';
import 'package:learning_app/constants/theme_font_constants.dart';

class SettingsGroup extends StatelessWidget {
  // calculated:
  final String title;
  final String subTitle;
  final IconData iconData;
  final Widget? action;

  const SettingsGroup(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.iconData,
      this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon
          Icon(
            iconData,
            color: Theme.of(context).colorScheme.onBackgroundHard,
          ),
          // Title and Subtitle
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                mainAxisAlignment: subTitle.isNotEmpty
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title,
                    maxLines: 2,
                    style: Theme.of(context)
                        .textTheme
                        .textStyle3
                        .withBold
                        .withOnBackgroundHard,
                  ),

                  // SUbtitle
                  if (subTitle.isNotEmpty)
                    Column(children: [
                      const SizedBox(height: 10),
                      Text(
                        subTitle,
                        maxLines: 2,
                        style: Theme.of(context)
                            .textTheme
                            .textStyle3
                            .withOnBackgroundSoft,
                      ),
                    ])
                ],
              ),
            ),
          ),
          if (action != null) action!,
        ],
      ),
    );
  }
}
