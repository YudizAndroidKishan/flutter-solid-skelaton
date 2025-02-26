import 'package:intl/intl.dart';

class DateUtilsHelper {
  /// Formats a [date] into a string using the given [pattern].
  static String formatDate(DateTime date, {String pattern = 'yyyy-MM-dd'}) {
    final formatter = DateFormat(pattern);
    return formatter.format(date);
  }

  /// Parses a [dateString] into a DateTime object using the given [pattern].
  static DateTime? parseDate(String dateString,
      {String pattern = 'yyyy-MM-dd'}) {
    try {
      final formatter = DateFormat(pattern);
      return formatter.parse(dateString);
    } catch (e) {
      return null;
    }
  }

  /// Returns the difference in days between [start] and [end].
  static int differenceInDays(DateTime start, DateTime end) {
    return end.difference(start).inDays;
  }
}
