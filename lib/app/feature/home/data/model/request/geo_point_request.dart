class GeoPointRequest {
  GeoPointRequest({
    required this.lat,
    required this.lon,
  });

  final double lat;
  final double lon;

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
      };
}
