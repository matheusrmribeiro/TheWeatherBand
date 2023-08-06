import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_band/app/core/api/api_client.dart';
import 'package:weather_band/app/core/api/response_wrapper.dart';
import 'package:weather_band/app/feature/home/data/datasource/remote/weather_datasource_impl.dart';
import 'package:weather_band/app/feature/home/data/model/request/geo_point_request.dart';
import 'package:weather_band/app/feature/home/domain/day_forecast_entity.dart';
import 'package:weather_band/app/feature/home/domain/repository/weather_repository_interface.dart';

class WeatherRepositoryImpl extends WeatherRepositoryInterface {

  final api = Modular.get<APIClient>();
  final datasource = WeatherDatasourceImpl();

  @override
  Future<ResponseWrapper> getWeather(GeoPointRequest request) async {
    final response = await datasource.getWeather(request);
    switch (response) {
      case ErrorWrapper():
        return response;
      case SuccessWrapper(data: var data):
        final entity = DayForecastEntity.fromMap(data);
        return SuccessWrapper(data: entity);
    }
  }

  @override
  Future<ResponseWrapper> getForecast(GeoPointRequest request) async {
    final response = await datasource.getForecast(request);
    switch (response) {
      case ErrorWrapper():
        return response;
      case SuccessWrapper(data: var data):
        final dataList = (data["list"] as List).map((e) => e as Map<String, dynamic>).toList();
        final entity = DayForecastEntity.fromMapList(dataList);
        return SuccessWrapper(data: entity);
    }
  }

}