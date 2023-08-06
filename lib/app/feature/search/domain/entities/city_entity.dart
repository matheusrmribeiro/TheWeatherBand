class CityEntity {
  CityEntity({
    required this.name,
    required this.country,
    required this.state,
    required this.lat,
    required this.lon,
  });

  final String name;
  final String country;
  final String? state;
  final double lat;
  final double lon;

  static CityEntity fromMap(Map<String, dynamic> map) =>
      CityEntity(
        name: map["name"],
        country: map["country"],
        state: map["state"],
        lat: map["lat"],
        lon: map["lon"],
      );

  static List<CityEntity> fromMapList(List<Map<String, dynamic>> map) =>
      map.map((e) => fromMap(e)).toList();

  Map<String, dynamic> toMap() =>
      {
        "name": name,
        "country": country,
        "state": state,
        "lat": lat,
        "lon": lon,
      };
}
