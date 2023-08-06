import 'package:weather_band/app/core/api/api_client.dart';
import 'package:weather_band/app/core/api/response_wrapper.dart';
import 'package:weather_band/app/core/constants.dart';
import 'package:weather_band/app/feature/home/data/model/request/geo_point_request.dart';

import 'home_datasource_interface.dart';

class HomeDatasourceImpl extends HomeDatasourceInterface {
  final api = APIClient();

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
