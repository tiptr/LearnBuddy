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
      final treatedDay = getBeginOfDay() as DateTime;

      final today = DateTime.now().getBeginOfDay() as DateTime;

      final Duration offset = treatedDay.difference(today);
      final dayOffset = offset.inDays;

      // Handle special cases for today, yesterday...
      switch (dayOffset) {
        case 0:
          return 'Heute';
        case 1:
          return 'Morgen';
        case -1:
          return 'Gestern';
      }

      if (dayOffset >= 2 && dayOffset <= 5) {
        return 'In $dayOffset Tagen';
      }

      if (dayOffset <= -2 && dayOffset >= -5) {
        return 'Vor ${dayOffset.abs()} Tagen';
      }

      // Don't show the year, if it is the current one:
      if (treatedDay.year == today.year) {
        return DateFormat('dd. MMM').format(treatedDay);
      } else {
        return DateFormat('dd. MMM y').format(treatedDay);
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

  DateTime? getBeginOfDay() {
    if (this == null) {
      return null;
    } else {
      final thisDate = this as DateTime;

      return DateTime(thisDate.year, thisDate.month, thisDate.day);
    }
  }

  /// Returns the date time of the begin of the day. If this day is in the past,
  /// it will return the begin of yesterday instead.
  ///
  /// Used e.g. for building a group of all over-due date-times
  DateTime? getBeginOfDayConcatPastToYesterday() {
    if (isInPast()) {
      final now = DateTime.now();
      final lastMidnight = DateTime(now.year, now.month, now.day);
      return lastMidnight.subtract(const Duration(days: 1));
    } else {
      return getBeginOfDay();
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
