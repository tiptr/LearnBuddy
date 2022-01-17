import 'package:flutter/material.dart';

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
  Function? onDelete,
  Function? onSettings,
  Function? onCategoryManagement,
  Function? onKeyWordsManagement,
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
          onSettings!();
          break;
        case ThreePointsMenuItems.categoryManagement:
          onCategoryManagement!();
          break;
        case ThreePointsMenuItems.keywordsManagement:
          onKeyWordsManagement!();
          break;
        case ThreePointsMenuItems.help:
          onHelp!();
          break;
      }
    },
    itemBuilder: (BuildContext context) =>
        <PopupMenuEntry<ThreePointsMenuItems>>[
      if (onDelete != null)
        PopupMenuItem<ThreePointsMenuItems>(
            value: ThreePointsMenuItems.delete,
            child: _buildMenuItem(
                title: 'Aufgabe löschen', iconData: Icons.delete_outlined)),

      if (onCategoryManagement != null)
        PopupMenuItem<ThreePointsMenuItems>(
            value: ThreePointsMenuItems.delete,
            child: _buildMenuItem(
                title: 'Kategorien verwalten',
                iconData: Icons.category_outlined)),
      if (onKeyWordsManagement != null)
        PopupMenuItem<ThreePointsMenuItems>(
            value: ThreePointsMenuItems.delete,
            child: _buildMenuItem(
                title: 'Schlagwörter verwalten',
                iconData: Icons.label_outline)),
      if (onHelp != null)
        PopupMenuItem<ThreePointsMenuItems>(
            value: ThreePointsMenuItems.delete,
            child: _buildMenuItem(
                title: 'Hilfe', iconData: Icons.help_outline)),
      if (onSettings != null)
        PopupMenuItem<ThreePointsMenuItems>(
            value: ThreePointsMenuItems.delete,
            child: _buildMenuItem(
                title: 'Einstellungen', iconData: Icons.settings_outlined)),
    ],
  );
}

Widget _buildMenuItem({required String title, required IconData iconData}) {
  return SizedBox(
    width: 300,
    child: ListTile(
      title: Text(title),
      trailing: Icon(
        iconData,
        color: const Color(0xFF636573),
      ),
    ),
  );
}
