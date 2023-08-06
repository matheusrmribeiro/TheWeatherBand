import 'package:weather_band/app/core/api/response_wrapper.dart';
import 'package:weather_band/app/core/base/base_view_model.dart';
import 'package:weather_band/app/core/base/enum/view_model_state_enum.dart';
import 'package:weather_band/app/core/enums.dart';
import 'package:weather_band/app/core/languages/language_utils.dart';
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
  List<DayForecastEntity> weekDayList = [];
  int position = 0;

  void setWeekDay(WeekDay value, int position) {
    selectedWeekDay = value;
    this.position = position;
    notifyListeners();
  }

  void fetchData() {
    blockLoading(
        message: LanguageUtils.getString("loading"),
        block: () async {
          final location = GeoPointRequest(
            lat: -22.275406919110882,
            lon: -48.52181823008409,
          );

          bool hasError = false;

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

          if (hasError)
            setState(ViewModelStateEnum.Error);
          else {
            weekDayList.sort((a, b) => a.date.compareTo(b.date));
            setState(ViewModelStateEnum.Idle);
          }
        });
  }
}
