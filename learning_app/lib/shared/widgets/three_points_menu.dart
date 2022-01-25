import 'package:flutter/material.dart';
import 'package:learning_app/constants/theme_color_constants.dart';
import 'package:learning_app/features/categories/screens/category_overview_screen.dart';
import 'package:learning_app/features/keywords/screens/keyword_overview_screen.dart';
import 'package:learning_app/features/settings/screens/settings_overview_screen.dart';
import 'package:learning_app/shared/widgets/gradient_icon.dart';
import 'package:learning_app/shared/widgets/three_points_menu_item.dart';

// This is the type used by the popup menu below.
enum ThreePointsMenuItems {
  delete,
  settings,
  categoryManagement,
  keywordsManagement,
  help,
  resetSettings,
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
  bool showResetSettings = false,
  // Local different options:
  Function? onDelete,
  Function? onHelp,
  Function? onResetSettings,
}) {
  return PopupMenuButton<ThreePointsMenuItems>(
    color: Theme.of(context).colorScheme.cardColor,
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

        case ThreePointsMenuItems.resetSettings:
          onResetSettings!();
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
      if (showResetSettings)
        const PopupMenuItem<ThreePointsMenuItems>(
          value: ThreePointsMenuItems.resetSettings,
          child: ThreePointsMenuItem(
              title: 'Zurücksetzen', iconData: Icons.undo_outlined),
        ),
    ],
    icon: gradientIcon(
      iconData: Icons.more_vert,
      size: 30,
      context: context,
    ),
  );
}
