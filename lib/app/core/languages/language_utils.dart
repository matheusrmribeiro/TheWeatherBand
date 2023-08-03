import 'language_view_model.dart';

class LanguageUtils {
  static String getString(String resId, { List<String> args = const [], isUpperCase = true }) {
    final String stringValue = LanguageViewModel().data[resId];
    var interpolatedString = stringValue;
    for (var arg in args) {
      interpolatedString = interpolatedString.replaceFirst("%@", arg);
    }
    return (isUpperCase) ? interpolatedString.toUpperCase() : interpolatedString;
  }

}