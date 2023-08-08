import 'package:weather_band/app/core/api/response_wrapper.dart';
import 'package:weather_band/app/feature/home/data/model/request/geo_point_request.dart';

abstract class WeatherRepositoryInterface {

  /// Get Weather
  ///
  /// Params
  ///   - [request] - The city latitude and longitude information.
  ///
  /// Returns the current day weather information based on server date time.
  ///
  Future<ResponseWrapper> getWeather(GeoPointRequest request);

  /// Get Forecast
  ///
  /// Params
  ///   - [request] - The city latitude and longitude information.
  ///
  /// Returns the next 5 days weather information based on server date time.
  ///
  Future<ResponseWrapper> getForecast(GeoPointRequest request);

}