import 'package:weather_band/app/core/base/base_view_model.dart';
import 'package:weather_band/app/core/constants.dart';
import 'package:weather_band/app/core/enums.dart';
import 'package:weather_band/app/feature/home/domain/day_forecast_entity.dart';

class HomeViewModel extends BaseViewModel {

  /// Initialize with the current day selected
  HomeViewModel() {
    final currentWeekDayIndex = DateTime.now().weekday -1;
    currentWeekDay = WeekDay.values.elementAt(currentWeekDayIndex);
    selectedWeekDay = currentWeekDay;
  }

  late WeekDay currentWeekDay;
  late WeekDay selectedWeekDay;
  late List<DayForecastEntity> weekDayList = [
    DayForecastEntity(
      date: DateTime.now(),
      temperature: 36,
      status: WeatherStatus.Sunny
    ),
    DayForecastEntity(
        date: DateTime.now().add(Duration(days: 1)),
        temperature: 29,
        status: WeatherStatus.Cloudy
    ),
    DayForecastEntity(
        date: DateTime.now().add(Duration(days: 2)),
        temperature: 18,
        status: WeatherStatus.Stormy
    ),
    DayForecastEntity(
        date: DateTime.now().add(Duration(days: 3)),
        temperature: -15,
        status: WeatherStatus.Snowing
    ),
    DayForecastEntity(
        date: DateTime.now().add(Duration(days: 3)),
        temperature: -15,
        status: WeatherStatus.Snowing
    ),
    DayForecastEntity(
        date: DateTime.now().add(Duration(days: 3)),
        temperature: -15,
        status: WeatherStatus.Snowing
    )
  ];
  int position = 0;

  void setWeekDay(WeekDay value, int position) {
    selectedWeekDay = value;
    this.position = position;
    notifyListeners();
  }


}