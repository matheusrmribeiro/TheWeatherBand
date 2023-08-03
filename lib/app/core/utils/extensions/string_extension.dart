extension StringExtension on String {
  String? ifNotEmptyOrNull({String? text}) {
    if ((isNotEmpty) && (this != "null"))
      return text ?? this;
    else
      return null;
  }

  String? setRequiredLabel(bool isRequired) {
    final text = this + ((isRequired) ? " *" : "");
    return text;
  }
}
