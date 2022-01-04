import 'package:drift/drift.dart';
import 'package:learning_app/features/learning_aids_body_list/models/body_parts.dart';

/// Allows storing the LearnMethods Enum as int
class BodyPartsConverter extends TypeConverter<BodyParts, int> {
  const BodyPartsConverter();
  @override
  BodyParts? mapToDart(int? fromDb) {
    if (fromDb == null) {
      return null;
    }
    return BodyParts.values[fromDb];
  }

  @override
  int? mapToSql(BodyParts? value) {
    if (value == null) {
      return null;
    }
    return value.index;
  }
}
