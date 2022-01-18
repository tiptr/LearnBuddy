import 'package:flutter/material.dart';
import 'package:learning_app/features/categories/screens/category_overview_screen.dart';
import 'package:learning_app/features/keywords/screens/keyword_overview_screen.dart';
import 'package:learning_app/features/settings/screens/settings_overview_screen.dart';
import 'package:learning_app/shared/widgets/three_points_menu_item.dart';

// This is the type used by the popup menu below.
enum ThreePointsMenuItems {
  delete,
  settings,
  categoryManagement,
  keywordsManagement,
  help,
}

/// General three-points menu to be used at various screens
///
/// Only the items will be displayed, for which handler functions are provided.
Widget buildThreePointsMenu({
  required BuildContext context,
  // Globally defined options:
  bool showGlobalSettings = false,
  bool showCategoryManagement = false,
  bool showKeyWordsManagement = false,
  // Local different options:
  Function? onDelete,
  Function? onHelp,
}) {
  return PopupMenuButton<ThreePointsMenuItems>(
    color: Colors.white,
    onSelected: (ThreePointsMenuItems result) {
      switch (result) {
        case ThreePointsMenuItems.delete:
          onDelete!();
          break;

        case ThreePointsMenuItems.settings:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SettingsOverviewScreen(),
            ),
          );
          break;

        case ThreePointsMenuItems.categoryManagement:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CategoryOverviewScreen(),
            ),
          );
          break;

        case ThreePointsMenuItems.keywordsManagement:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const KeyWordOverviewScreen(),
            ),
          );
          break;

        case ThreePointsMenuItems.help:
          onHelp!();
          break;
      }
    },
    itemBuilder: (BuildContext context) =>
        <PopupMenuEntry<ThreePointsMenuItems>>[
      if (onDelete != null)
        const PopupMenuItem<ThreePointsMenuItems>(
          value: ThreePointsMenuItems.delete,
          child: ThreePointsMenuItem(
              title: 'Aufgabe löschen', iconData: Icons.delete_outlined),
        ),
      if (showCategoryManagement)
        const PopupMenuItem<ThreePointsMenuItems>(
          value: ThreePointsMenuItems.categoryManagement,
          child: ThreePointsMenuItem(
              title: 'Kategorien verwalten', iconData: Icons.category_outlined),
        ),
      if (showKeyWordsManagement)
        const PopupMenuItem<ThreePointsMenuItems>(
            value: ThreePointsMenuItems.keywordsManagement,
            child: ThreePointsMenuItem(
                title: 'Schlagwörter verwalten',
                iconData: Icons.label_outline)),
      if (onHelp != null)
        const PopupMenuItem<ThreePointsMenuItems>(
          value: ThreePointsMenuItems.help,
          child:
              ThreePointsMenuItem(title: 'Hilfe', iconData: Icons.help_outline),
        ),
      if (showGlobalSettings)
        const PopupMenuItem<ThreePointsMenuItems>(
          value: ThreePointsMenuItems.settings,
          child: ThreePointsMenuItem(
              title: 'Einstellungen', iconData: Icons.settings_outlined),
        ),
    ],
  );
}
