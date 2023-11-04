import 'package:intl/intl.dart';

class DateUtil {
  String formatDateToMonthDayYear(DateTime date) {
    return DateFormat('E, MMM d, yyyy').format(date);
  }
   String formatDateToMonthDayYearToHourMinute(DateTime date) {
    return DateFormat('h:mm a').format(date);
  }
 String formatDateToMonthDay(DateTime date) {
    return DateFormat('MMM d').format(date);
  }
  String formatDateToMonthDayHourMinute(DateTime date){
      return DateFormat('MMM d, h:mm a').format(date);
  }
}
