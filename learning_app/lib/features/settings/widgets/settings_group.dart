import 'package:flutter/material.dart';

class SettingsGroup extends StatelessWidget {
  // calculated:
  final String title;
  final String subTitle;
  final IconData iconData;

  const SettingsGroup({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.iconData,
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
          Icon(
            iconData,
            color: const Color(0xFF636573),
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
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                      color: Color(0xFF636573),
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
