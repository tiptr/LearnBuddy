import 'package:flutter/material.dart';

// This is the type used by the popup menu below.
enum TaskDetailsMenuItems { delete }

/// Three-points menu displayed for the details screen of existing tasks
Widget buildThreePointsMenu({
  required Function onDelete,
}) {
  return PopupMenuButton<TaskDetailsMenuItems>(
    onSelected: (TaskDetailsMenuItems result) {
      switch (result) {
        case TaskDetailsMenuItems.delete:
          onDelete();
          break;
      }
    },
    itemBuilder: (BuildContext context) =>
        <PopupMenuEntry<TaskDetailsMenuItems>>[
      const PopupMenuItem<TaskDetailsMenuItems>(
        value: TaskDetailsMenuItems.delete,
        child: Text('Aufgabe löschen'),
      ),
      // ...
    ],
  );
}
