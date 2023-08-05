import 'package:flutter/material.dart';
import 'package:weather_band/app/core/enums.dart';
import 'package:weather_band/app/core/theme/app_colors.dart';
import 'package:weather_band/app/feature/home/domain/day_forecast_entity.dart';

import 'widgets/header_widget.dart';

class WeatherDayPage extends StatelessWidget {
  const WeatherDayPage({Key? key, required this.dayForecast}) : super(key: key);

  final DayForecastEntity dayForecast;

  Color getWeatherColor() {
    switch (dayForecast.status) {
      case WeatherStatus.Sunny: return AppColors.sunnyColor;
      case WeatherStatus.PartiallyCloudy: return AppColors.partiallyCloudyColor;
      case WeatherStatus.Cloudy: return AppColors.cloudyColor;
      case WeatherStatus.Stormy: return AppColors.stormyColor;
      case WeatherStatus.Snowing: return AppColors.snowingColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: getWeatherColor(),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWidget(
              dateTime: dayForecast.date,
              cityName: "City Name Here",
            )
          ],
        ),
      ),
    );
  }
}
