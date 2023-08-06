import 'package:weather_band/app/core/api/response_wrapper.dart';
import 'package:weather_band/app/feature/home/data/model/request/geo_point_request.dart';

abstract class WeatherRepositoryInterface {

  Future<ResponseWrapper> getWeather(GeoPointRequest request);

  Future<ResponseWrapper> getForecast(GeoPointRequest request);

}