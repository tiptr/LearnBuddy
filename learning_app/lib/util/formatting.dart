import 'package:intl/intl.dart';

class Formatting {
  static String formatDuration(Duration? duration, String alternative) {
    if (duration == null) return alternative;

    var hours = (duration.inMinutes / 60).floor().toString();
    var minutes = (duration.inMinutes % 60).toString();
    return "$hours h $minutes min";
  }

  static String formatDateTime(DateTime? dateTime, String alternative) {
    if (dateTime == null) return alternative;

    return DateFormat('dd.MM.yyyy').format(dateTime);
  }
}
