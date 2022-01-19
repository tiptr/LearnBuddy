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

  String formatShort({String? ifNull}) {
    if (this == null) {
      return ifNull ?? 'Ohne Dauer';
    } else {
      final duration = this as Duration;

      final hours = (duration.inMinutes / 60).floor();
      final minutes = (duration.inMinutes % 60).toString();

      return hours > 0 ? "${hours.toString()} h $minutes min" : "$minutes min";
    }
  }

  String toExactSecondsFormat({String? ifNull}) {
    if (this == null) {
      return ifNull ?? 'Ohne Dauer';
    } else {
      final duration = this as Duration;

      final hours = (duration.inMinutes / 60).floor();
      String hoursString = hours == 0 ? "" : "$hours h ";
      final minutes = (duration.inMinutes % 60);
      String minutesString = minutes == 0 ? "" : "$minutes min ";
      final secondsString = (duration.inSeconds % 60).toString() + " sec";
      return hoursString + minutesString + secondsString;
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
      final int fiveMinRoundedMinutes = (minutes / 5).round() * 5;
      final int halfHoursRounded = (duration.inMinutes / 30).round();
      final int halfHoursRoundedBeforeComma = (halfHoursRounded / 2).floor();
      final int halfHoursRoundedAfterComma = (halfHoursRounded % 2).floor() * 5;

      if (hours == 0) {
        return '~ $fiveMinRoundedMinutes min';
      } else {
        return '~ $halfHoursRoundedBeforeComma,$halfHoursRoundedAfterComma h';
      }
    }
  }
}
