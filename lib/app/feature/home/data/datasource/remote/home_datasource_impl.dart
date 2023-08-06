import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_band/app/core/api/api_client.dart';
import 'package:weather_band/app/core/api/response_wrapper.dart';
import 'package:weather_band/app/core/constants.dart';
import 'package:weather_band/app/feature/home/data/model/request/geo_point_request.dart';

import 'home_datasource_interface.dart';

class HomeDatasourceImpl extends HomeDatasourceInterface {
  final api = Modular.get<APIClient>();
  final apiGeo = APIClient(baseUrl: kSERVER_BASE_GEO);

  @override
  Future<ResponseWrapper> search(String search) {
    final query = {"q": search};
    return apiGeo.request(type: RequestType.get, path: "/direct", query: query);
  }

  @override
  Future<ResponseWrapper> getWeather(GeoPointRequest request) {
    final query = request.toJson();
    query["units"] = kUNITS_MEASUREMENT;
    return api.request(type: RequestType.get, path: "/weather", query: query);
  }

  @override
  Future<ResponseWrapper> getForecast(GeoPointRequest request) {
    final query = request.toJson();
    query["units"] = kUNITS_MEASUREMENT;
    query["cnt"] = 5;
    return api.request(type: RequestType.get, path: "/forecast", query: query);
  }
}
