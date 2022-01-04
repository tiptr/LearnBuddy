import 'package:drift/drift.dart';
import 'package:learning_app/features/learning_aids/models/learn_methods.dart';

/// Allows storing the LearnMethods Enum as int
class LearnMethodsConverter extends TypeConverter<LearnMethods, int> {
  const LearnMethodsConverter();
  @override
  LearnMethods? mapToDart(int? fromDb) {
    if (fromDb == null) {
      return null;
    }
    return LearnMethods.values[fromDb];
  }

  @override
  int? mapToSql(LearnMethods? value) {
    if (value == null) {
      return null;
    }
    return value.index;
  }
}
