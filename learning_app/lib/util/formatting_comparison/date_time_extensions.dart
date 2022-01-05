import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime? {
  String format({String? ifNull}) {
    if (this == null) {
      return ifNull ?? 'Ohne Datum';
    } else {
      final dateTime = this as DateTime;
      return DateFormat('dd.MM.yyyy').format(dateTime);
    }
  }

  /// Provides a short string representation of a Date
  ///
  /// Without the year, if equal to the current.
  /// E.g. 'Today', if the current day is matched.
  String toListViewFormat({String? ifNull}) {
    if (this == null) {
      return ifNull ?? 'Ohne Datum';
    } else {
      final dateTime = this as DateTime;

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
  }
}

extension DateTimeComparing on DateTime? {
  int compareDayOnly(DateTime? otherDate) {
    if (this == null) {
      return 1;
    } else {
      final thisDate = this as DateTime;

      if (otherDate == null) {
        return -1;
      } else {
        // It does not matter here, if a month is actually shorter!
        final compareInt =
            thisDate.day + 31 * thisDate.month + 365 * thisDate.year;
        final otherCompareInt =
            otherDate.day + 31 * otherDate.month + 365 * otherDate.year;
        return compareInt.compareTo(otherCompareInt);
      }
    }
  }

  DateTime? getPreviousMidnight() {
    if (this == null) {
      return null;
    } else {
      final thisDate = this as DateTime;

      return DateTime(thisDate.year, thisDate.month, thisDate.day);
    }
  }

  bool isInPast() {
    if (this == null) {
      return false;
    } else {
      final thisDate = this as DateTime;

      final now = DateTime.now();
      final lastMidnight = DateTime(now.year, now.month, now.day);
      return thisDate.isBefore(lastMidnight);
    }
  }
}
