import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_band/app/core/enums.dart';
import 'package:weather_band/app/core/theme/app_colors.dart';
import 'package:weather_band/app/core/utils/extensions/enum_extension.dart';
import 'package:weather_band/app/feature/home/domain/day_forecast_entity.dart';

class ForecastSelectorWidget extends StatelessWidget {
  const ForecastSelectorWidget({
    Key? key,
    required this.tabController,
    required this.daysForecast,
  }) : super(key: key);

  final TabController tabController;
  final List<DayForecastEntity> daysForecast;

  String getWeekDayName(DateTime value) {
    final name = DateFormat("EEE").format(value);
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
          child: TabBar(
            indicatorColor: Colors.transparent,
            labelStyle: TextStyle(
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.normal,
            ),
            controller: tabController,
            tabs: daysForecast
                .map((day) => Tab(
                      text: getWeekDayName(day.date).toUpperCase(),
                    ))
                .toList()
          ),
        ),
      ],
    );
  }
}
