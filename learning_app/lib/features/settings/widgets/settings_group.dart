import 'package:flutter/material.dart';

class SettingsGroup extends StatelessWidget {
  // calculated:
  final String title;
  final String subTitle;
  final Icon icon;

  const SettingsGroup({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.icon,
  }) : super(key: key);

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
          icon,
          // const SizedBox(width: 5.0),
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
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                      color: Color(0xFF40424A),
                    ),
                  ),

                  // SUbtitle
                  if (subTitle.isNotEmpty)
                    Column(children: [
                      const SizedBox(height: 10),
                      Text(
                        subTitle,
                        maxLines: 2,
                        style: const TextStyle(
                          color: Color(0xFF949597),
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ])
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
