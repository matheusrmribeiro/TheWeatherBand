import 'package:flutter/material.dart';
import 'package:weather_band/app/core/enums.dart';
import 'package:weather_band/app/core/theme/app_colors.dart';
import 'package:weather_band/app/core/utils/extensions/enum_extension.dart';

class ForecastSelectorWidget extends StatelessWidget {
  const ForecastSelectorWidget({
    Key? key,
    required this.currentWeekDay,
    required this.selectedWeekDay,
    required this.onChangeDaySelected,
  }) : super(key: key);

  final WeekDay currentWeekDay;
  final WeekDay selectedWeekDay;
  final Function(WeekDay, int) onChangeDaySelected;

  List<WeekDay> weekDaysList() {
    final sortedList = [currentWeekDay];
    const weekDays = WeekDay.values;
    final maxHigherDays = weekDays.length - (currentWeekDay.index + 1);
    final maxLowerDays = 5 - maxHigherDays;
    final lowerWeekDays = weekDays
        .where((element) => element.index < currentWeekDay.index)
        .take(maxLowerDays);
    final higherWeekDays = weekDays
        .where((element) => element.index > currentWeekDay.index)
        .take(maxHigherDays);

    sortedList.addAll(higherWeekDays);
    sortedList.addAll(lowerWeekDays);
    return sortedList;
  }

  @override
  Widget build(BuildContext context) {
    final weekDayList = weekDaysList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: weekDayList
                .map((weekDay) => GestureDetector(
                      onTap: () {
                        onChangeDaySelected.call(
                            weekDay, weekDayList.indexOf(weekDay));
                      },
                      child: Text(
                        weekDay.toText.substring(0, 3).toUpperCase(),
                        textScaleFactor:
                            (weekDay == selectedWeekDay) ? 1.2 : null,
                        style: TextStyle(
                          color: AppColors.grey,
                          fontWeight: (weekDay == selectedWeekDay)
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
