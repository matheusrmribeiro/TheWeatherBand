import 'package:intl/intl.dart';

class DoubleUtils {

  static String doubleToText(double? value) {
    if (value == null)
      return "";
    final formatter = NumberFormat.currency(locale: "pt_Br", symbol: "");
    return formatter.format(value);
  }
}