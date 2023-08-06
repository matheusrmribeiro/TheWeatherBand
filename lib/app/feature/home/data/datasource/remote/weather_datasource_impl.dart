import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_band/app/core/api/api_client.dart';
import 'package:weather_band/app/core/api/response_wrapper.dart';
import 'package:weather_band/app/feature/home/data/model/request/geo_point_request.dart';

import 'weather_datasource_interface.dart';

class WeatherDatasourceImpl extends WeatherDatasourceInterface {

  final api = Modular.get<APIClient>();

  @override
  Future<ResponseWrapper> getWeather(GeoPointRequest request) {
    return api.request(type: RequestType.get, path: "/weather", query: request.toJson());
  }

  @override
  Future<ResponseWrapper> getForecast(GeoPointRequest request) {
    final query = request.toJson();
    query["cnt"] = 5;
    return api.request(type: RequestType.get, path: "/forecast", query: query);

  }

}