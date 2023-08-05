import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_band/app/core/theme/app_colors.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key, required this.dateTime, required this.cityName}) : super(key: key);

  final DateTime dateTime;
  final String cityName;

  String getWeekDayName() {
    final name = DateFormat("EEEE dd").format(dateTime);
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getWeekDayName(),
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              color: AppColors.white),
        ),
      ],
    );
  }
}
