import 'dart:ui';
import 'package:drift/drift.dart';

/// Allows storing Colors as int
class ColorConverter extends TypeConverter<Color, int> {
  const ColorConverter();
  @override
  Color? mapToDart(int? fromDb) {
    if (fromDb == null) {
      return null;
    }
    return Color(fromDb);
  }

  @override
  int? mapToSql(Color? value) {
    if (value == null) {
      return null;
    }
    return value.value;
  }
}
