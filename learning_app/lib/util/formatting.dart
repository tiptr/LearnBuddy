import 'package:intl/intl.dart';

class Formatting {
  static String formatDuration(Duration? duration, String alternative) {
    if (duration == null) return alternative;

    final hours = (duration.inMinutes / 60).floor().toString();
    final minutes = (duration.inMinutes % 60).toString();
    return "$hours h $minutes min";
  }

  /// Provides a rounded String representation of a duration
  static String formatDurationForListView(
      Duration? duration, String alternative) {
    if (duration == null) return alternative;

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

  static String formatDateTime(DateTime? dateTime, String alternative) {
    if (dateTime == null) return alternative;

    return DateFormat('dd.MM.yyyy').format(dateTime);
  }

  /// Provides a short string representation of a Date
  ///
  /// Without the year, if equal to the current.
  /// E.g. 'Today', if the current day is matched.
  static String formatDateTimeForListView(
      DateTime? dateTime, String alternative) {
    if (dateTime == null) return alternative;
    final now = DateTime.now();
    final day = dateTime.day;
    final currentDay = now.day;
    final dayOffset = day - currentDay;

    // Handle special cases for today, yesterday...
    switch (dayOffset) {
      case 0:
        return 'Heute';
      case 1:
        return 'Morgen';
      case 2:
        return 'Übermorgen';
      case -1:
        return 'Gestern';
      case -2:
        return 'Vorgestern';
    }

    if (dayOffset >= 3 && dayOffset <= 5) {
      return 'In $dayOffset Tagen';
    }

    if (dayOffset <= -3 && dayOffset >= -5) {
      return 'Vor ${dayOffset.abs()} Tagen';
    }

    // Don't show the year, if it is the current one:
    if (dateTime.year == now.year) {
      return DateFormat('dd. MMM').format(dateTime);
    } else {
      return DateFormat('dd. MMM y').format(dateTime);
    }
  }

  static bool isDateTimeInPast(DateTime? dateTime) {
    if (dateTime == null) return false;

    final now = DateTime.now();
    final lastMidnight = DateTime(now.year, now.month, now.day);
    return dateTime.isBefore(lastMidnight);
  }
}
