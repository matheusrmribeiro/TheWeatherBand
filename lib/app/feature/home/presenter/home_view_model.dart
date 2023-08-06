import 'package:weather_band/app/core/api/response_wrapper.dart';
import 'package:weather_band/app/core/base/base_view_model.dart';
import 'package:weather_band/app/core/constants.dart';
import 'package:weather_band/app/core/enums.dart';
import 'package:weather_band/app/core/languages/language_utils.dart';
import 'package:weather_band/app/core/widgets/toast.dart';
import 'package:weather_band/app/feature/home/data/model/request/geo_point_request.dart';
import 'package:weather_band/app/feature/home/data/repository/weather_repository_impl.dart';
import 'package:weather_band/app/feature/home/domain/day_forecast_entity.dart';

class HomeViewModel extends BaseViewModel {
  final WeatherRepositoryImpl repository = WeatherRepositoryImpl();

  /// Initialize with the current day selected
  HomeViewModel() {
    final currentWeekDayIndex = DateTime.now().weekday - 1;
    currentWeekDay = WeekDay.values.elementAt(currentWeekDayIndex);
    selectedWeekDay = currentWeekDay;
  }

  late WeekDay currentWeekDay;
  late WeekDay selectedWeekDay;
  bool hasError = false;
  List<DayForecastEntity> weekDayList = [];
  int position = 0;

  void setWeekDay(WeekDay value, int position) {
    selectedWeekDay = value;
    this.position = position;
    notifyListeners();
  }

  Future<void> fetchData() async {
    final location = GeoPointRequest(
      lat: -22.275406919110882,
      lon: -48.52181823008409,
    );

    final responses = await Future.wait(<Future>[
      repository.getWeather(location),
      repository.getForecast(location)
    ], eagerError: true, cleanUp: (value) {
      hasError = true;
    });

    for (final response in responses) {
      if (response is SuccessWrapper) {
        if (response.data is List)
          weekDayList.addAll(response.data);
        else
          weekDayList.add(response.data);
      } else
        hasError = true;
    }

    weekDayList.sort((a, b) => a.date.compareTo(b.date));
    notifyListeners();
  }

}
