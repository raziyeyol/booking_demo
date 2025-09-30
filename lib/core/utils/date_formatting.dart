import 'package:intl/intl.dart';

class DateFormatting {
  static final DateFormat timeRange = DateFormat('EEE, d MMM HH:mm');

  static String range(DateTime start, DateTime end) {
    final startStr = timeRange.format(start);
    final endStr = DateFormat('HH:mm').format(end);
    return startStr + ' - ' + endStr;
  }
}
