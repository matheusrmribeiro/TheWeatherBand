import 'package:weather_band/app/core/api/response_wrapper.dart';
import 'package:weather_band/app/core/base/base_view_model.dart';
import 'package:weather_band/app/core/base/enum/view_model_state.dart';
import 'package:weather_band/app/core/enums.dart';
import 'package:weather_band/app/core/languages/language_utils.dart';
import 'package:weather_band/app/feature/home/data/model/request/geo_point_request.dart';
import 'package:weather_band/app/feature/home/data/repository/weather_repository_impl.dart';
import 'package:weather_band/app/feature/home/domain/entities/day_forecast_entity.dart';
import 'package:weather_band/app/feature/search/domain/entities/city_entity.dart';

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
  CityEntity? selectedCity;

  void setWeekDay(WeekDay value, int position) {
    selectedWeekDay = value;
    notifyListeners();
  }

  void setSelectedCity(CityEntity city) {
    selectedCity = city;
    fetchData();
    notifyListeners();
  }

  void fetchData() {
    blockLoading(
        message: LanguageUtils.getString("loading_weather"),
        block: () async {
          if (selectedCity != null) {
            final location = GeoPointRequest(
              lat: selectedCity!.lat,
              lon: selectedCity!.lon,
            );

            bool hasError = false;

            final responses = await Future.wait(<Future>[
              repository.getWeather(location),
              repository.getForecast(location)
            ], eagerError: true, cleanUp: (value) {
              hasError = true;
            });

             weekDayList.clear();
            for (final response in responses) {
              if (response is SuccessWrapper) {
                if (response.data is List)
                  weekDayList.addAll(response.data);
                else
                  weekDayList.add(response.data);
              } else {
                hasError = true;
                break;
              }
            }

            if (hasError)
              setState(ErrorState(
                  message: LanguageUtils.getString("error_weather")));
            else {
              weekDayList.sort((a, b) => a.date.compareTo(b.date));
              setState(IdleState());
            }
          } else
            setState(IdleState());
        });
  }
}
