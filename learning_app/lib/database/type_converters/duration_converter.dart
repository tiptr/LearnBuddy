import 'package:drift/drift.dart';

/// Allows storing Durations as int
class DurationConverter extends TypeConverter<Duration, int> {
  const DurationConverter();
  @override
  Duration? mapToDart(int? fromDb) {
    if (fromDb == null) {
      return null;
    }
    return Duration(seconds: fromDb);
  }

  @override
  int? mapToSql(Duration? value) {
    if (value == null) {
      return null;
    }
    return value.inSeconds;
  }
}
