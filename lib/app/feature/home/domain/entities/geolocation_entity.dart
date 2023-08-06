class GeolocationEntity {
  GeolocationEntity({
    required this.nameEn,
    required this.nameBr,
    required this.country,
    required this.state,
    required this.lat,
    required this.lon,
  });

  final String nameEn;
  final String nameBr;
  final String country;
  final String? state;
  final double lat;
  final double lon;

  static GeolocationEntity fromMap(Map<String, dynamic> map) =>
      GeolocationEntity(
        nameEn: map["local_names"]["pt"],
        nameBr: map["local_names"]["en"],
        country: map["country"],
        state: map["state"],
        lat: map["lat"],
        lon: map["lon"],
      );

  static List<GeolocationEntity> fromMapList(List<Map<String, dynamic>> map) =>
      map.map((e) => fromMap(e)).toList();
}
