import 'package:intl/intl.dart';

class DateUtils {

  static String formatStringDateFromServer(String? date) {
    if (date == null)
      return "";
    DateTime serverDate = DateFormat("yyyy-MM-dd").parse(date);
    String formattedDate = DateFormat("dd/MM/yyyy").format(serverDate);
    return formattedDate;
  }

  static String formatStringDateTimeFromServer(String? date) {
    if (date == null)
      return "";
    DateTime serverDate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(date);
    String formattedDate = DateFormat("dd/MM/yyyy hh:mm:ss").format(serverDate);
    return formattedDate;
  }

}