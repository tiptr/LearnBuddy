import 'package:flutter/material.dart';
import 'package:learning_app/constants/theme_color_constants.dart';
import 'package:learning_app/constants/theme_font_constants.dart';

class SettingsGroup extends StatelessWidget {
  // calculated:
  final String title;
  final String subTitle;
  final IconData iconData;
  final bool? colorHard;
  final Widget? action;

  const SettingsGroup(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.iconData,
      this.colorHard,
      this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = Theme.of(context).textTheme.textStyle3.withBold;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon
          Icon(
            iconData,
            color: colorHard ?? false
                ? Theme.of(context).colorScheme.onBackgroundHard
                : Theme.of(context).colorScheme.onBackground,
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
                    style: colorHard ?? false
                        ? titleStyle.withOnBackgroundHard
                        : titleStyle,
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
