extension MapExtension on Map<String, dynamic> {

  Map<String, dynamic> removeNullAndEmptyValues() {
    removeWhere((key, value) => value == null || value == "");
    return this;
  }

}