import 'dart:ui';

import 'theme/app_colors.dart';

enum WeekDay {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday,
}

enum WeatherStatus {
  Sunny,
  PartiallyCloudy,
  Cloudy,
  Rainy,
  Stormy,
  Snowing,
  Mist;

  static WeatherStatus getByString(String value) {
    switch (value.toLowerCase()) {
      case "clear sky" || "few clouds": return Sunny;
      case "scattered clouds" || "clouds": return PartiallyCloudy;
      case "broken clouds": return Cloudy;
      case "rain" || "shower rain": return Rainy;
      case "thunderstorm": return Stormy;
      case "snow": return Snowing;
      case "mist": return Mist;
      default: return Sunny;
    }
  }

  Color getWeatherColor() {
    switch (this) {
      case WeatherStatus.Sunny:
        return AppColors.sunnyColor;
      case WeatherStatus.PartiallyCloudy:
        return AppColors.partiallyCloudyColor;
      case WeatherStatus.Cloudy:
        return AppColors.cloudyColor;
      case WeatherStatus.Rainy:
        return AppColors.rainyColor;
        case WeatherStatus.Stormy:
        return AppColors.stormyColor;
      case WeatherStatus.Snowing:
        return AppColors.snowingColor;
      case WeatherStatus.Mist:
        return AppColors.mistyColor;
    }
  }

  String getWeatherIcon() {
    switch (this) {
      case WeatherStatus.Sunny:
        return "assets/images/sunny.svg";
      case WeatherStatus.PartiallyCloudy:
        return "assets/images/partially_cloudy.svg";
      case WeatherStatus.Cloudy:
        return "assets/images/cloudy.svg";
      case WeatherStatus.Rainy:
        return "assets/images/rainy.svg";
        case WeatherStatus.Stormy:
        return "assets/images/stormy.svg";
      case WeatherStatus.Snowing:
        return "assets/images/snowing.svg";
      case WeatherStatus.Mist:
        return "assets/images/misty.svg";
    }
  }

}