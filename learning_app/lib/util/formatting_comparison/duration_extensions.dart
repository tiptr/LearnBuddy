import 'package:intl/intl.dart';

extension DurationFormatting on Duration? {
  String format({String? ifNull}) {
    if (this == null) {
      return ifNull ?? 'Ohne Dauer';
    } else {
      final duration = this as Duration;

      final hours = (duration.inMinutes / 60).floor().toString();
      final minutes = (duration.inMinutes % 60).toString();
      return "$hours h $minutes min";
    }
  }

  /// Provides a rounded String representation of a duration
  String toListViewFormat({String? ifNull}) {
    if (this == null) {
      return ifNull ?? 'Ohne Dauer';
    } else {
      final duration = this as Duration;

      final int hours = (duration.inMinutes / 60).floor();
      final int minutes = (duration.inMinutes % 60);
      final int roundedMinutes = (minutes ~/ 15) * 15;

      if (hours == 0) {
        return '~ $roundedMinutes min';
      } else if (hours <= 2) {
        return '~ $hours h, $roundedMinutes min';
      } else {
        return '~ $hours h';
      }
    }
  }
}
