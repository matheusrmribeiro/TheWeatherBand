import 'package:weather_band/app/core/enums.dart';

class DayForecastEntity {
  DayForecastEntity({
    required this.date,
    required this.temperature,
    required this.status,
  });

  final DateTime date;
  final double temperature;
  final WeatherStatus status;

  static DayForecastEntity fromMap(Map<String, dynamic> map) {
    final temp = map["main"]["temp"];
    return DayForecastEntity(
      date: map["date"],
      temperature: (temp is int) ? temp.toDouble() : temp,
      status: WeatherStatus.getByString(map["weather"][0]["main"]),
    );
  }

  static List<DayForecastEntity> fromMapList(List<Map<String, dynamic>> map) =>
      map.map((e) => fromMap(e)).toList();
}
