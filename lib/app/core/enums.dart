import 'dart:ui';

import 'theme/app_colors.dart';

enum WeekDay {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday
}

enum WeatherStatus {
  Sunny,
  PartiallyCloudy,
  Cloudy,
  Stormy,
  Snowing;

  Color getWeatherColor() {
    switch (this) {
      case WeatherStatus.Sunny:
        return AppColors.sunnyColor;
      case WeatherStatus.PartiallyCloudy:
        return AppColors.partiallyCloudyColor;
      case WeatherStatus.Cloudy:
        return AppColors.cloudyColor;
      case WeatherStatus.Stormy:
        return AppColors.stormyColor;
      case WeatherStatus.Snowing:
        return AppColors.snowingColor;
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
      case WeatherStatus.Stormy:
        return "assets/images/stormy.svg";
      case WeatherStatus.Snowing:
        return "assets/images/snowing.svg";
    }
  }

}