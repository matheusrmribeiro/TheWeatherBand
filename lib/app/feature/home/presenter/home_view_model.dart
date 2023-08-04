import 'package:weather_band/app/core/base/base_view_model.dart';
import 'package:weather_band/app/core/enums.dart';

class HomeViewModel extends BaseViewModel {

  /// Initialize with the current day selected
  HomeViewModel() {
    final currentWeekDayIndex = DateTime.now().weekday -1;
    currentWeekDay = WeekDay.values.elementAt(currentWeekDayIndex);
    selectedWeekDay = currentWeekDay;
  }

  late WeekDay currentWeekDay;
  late WeekDay selectedWeekDay;
  int position = 0;

  void setWeekDay(WeekDay value, int position) {
    selectedWeekDay = value;
    this.position = position;
    notifyListeners();
  }

}