import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:weather_band/app/core/theme/app_colors.dart';
import 'package:weather_band/app/core/utils/extensions/enum_extension.dart';
import 'package:weather_band/app/core/widgets/custom_divider_widget.dart';
import 'package:weather_band/app/feature/home/domain/entities/day_forecast_entity.dart';

class WeatherDayPage extends StatelessWidget {
  const WeatherDayPage({Key? key, required this.dayForecast}) : super(key: key);

  final DayForecastEntity dayForecast;

  String getWeekDayName() {
    final name = DateFormat("EEEE dd").format(dayForecast.date);
    return name;
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColorStart = dayForecast.status.getWeatherColor();
    final backgroundColorEnd =
        HSLColor.fromColor(backgroundColorStart).withLightness(0.6).toColor();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            backgroundColorStart,
            backgroundColorEnd,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomDividerWidget(
                height: 50,
              ),
              SvgPicture.asset(dayForecast.status.getWeatherIcon(),
                  height: 100,
                  width: 100,
                  alignment: Alignment.center,
                  semanticsLabel: dayForecast.status.toText),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "${dayForecast.temperature.toInt()}º",
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 80,
                      fontWeight: FontWeight.w100),
                ),
              ),
              Text(
                getWeekDayName(),
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
