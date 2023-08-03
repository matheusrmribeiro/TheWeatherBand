import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {

  String toText({String? format = "dd/MM/yyyy"}) {
    return DateFormat(format).format(this);
  }

}