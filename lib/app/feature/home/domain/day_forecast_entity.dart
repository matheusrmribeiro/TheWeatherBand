import 'package:weather_band/app/core/enums.dart';

class DayForecastEntity {
  DayForecastEntity({
    required this.date,
    required this.temperature,
    required this.status,
  });

  final DateTime date;
  final int temperature;
  final WeatherStatus status;
}
