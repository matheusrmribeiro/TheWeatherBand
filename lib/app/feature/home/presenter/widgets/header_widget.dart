import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_band/app/core/theme/app_colors.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key, required this.selectedWeekDayPosition}) : super(key: key);

  final int selectedWeekDayPosition;

  String getWeekDayName(int position) {
    final day = DateTime.now().add(Duration(days: position));
    final name = DateFormat("EEEE dd").format(day);
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getWeekDayName(selectedWeekDayPosition),
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              color: AppColors.white),
        ),
      ],
    );
  }
}
