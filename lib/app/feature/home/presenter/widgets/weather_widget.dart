import 'package:flutter/material.dart';
import 'package:weather_band/app/feature/home/domain/day_forecast_entity.dart';
import 'package:weather_band/app/feature/home/presenter/weather_day_page.dart';
import 'package:weather_band/app/feature/home/presenter/widgets/forecast_selector_widget.dart';
import 'package:weather_band/app/feature/home/presenter/widgets/header_widget.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({
    Key? key,
    required this.tabController,
    required this.weekDayList,
  }) : super(key: key);

  final TabController tabController;
  final List<DayForecastEntity> weekDayList;

  @override
  Widget build(BuildContext context) {
    final weatherStatus = weekDayList[tabController.index].status;
    final backgroundColor =
    HSLColor.fromColor(weatherStatus.getWeatherColor())
        .withSaturation(0.8)
        .toColor();

    return Stack(
      children: [
        TabBarView(
            controller: tabController,
            physics: AlwaysScrollableScrollPhysics(),
            children: weekDayList
                .map((day) => WeatherDayPage(dayForecast: day))
                .toList()),
        Align(
          alignment: Alignment.topCenter,
          child: SafeArea(
            child: HeaderWidget(
              statusColor: backgroundColor,
              cityName: "City Name Here",
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 30,
            margin: EdgeInsets.only(bottom: 20),
            child: ForecastSelectorWidget(
              tabController: tabController,
              daysForecast: weekDayList,
            ),
          ),
        )
      ],
    );
  }
}
