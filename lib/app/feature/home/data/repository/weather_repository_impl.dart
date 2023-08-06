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
    final ResponseWrapper finalResponse;

    switch (response) {
      case ErrorWrapper():
        finalResponse = response;
      case SuccessWrapper(data: var data):
        data["date"] = DateTime.now();
        final entity = DayForecastEntity.fromMap(data);
        finalResponse = SuccessWrapper(data: entity);
    }

    return finalResponse;
  }

  @override
  Future<ResponseWrapper> getForecast(GeoPointRequest request) async {
    final response = await datasource.getForecast(request);
    final ResponseWrapper finalResponse;

    switch (response) {
      case ErrorWrapper():
        finalResponse = response;
      case SuccessWrapper(data: var data):
        final dataList = (data["list"] as List)
            .map((e) => e as Map<String, dynamic>)
            .toList();
        dataList.asMap().forEach((index, element) {
          element["date"] = DateTime.now().add(Duration(days: index + 1));
        });
        final entity = DayForecastEntity.fromMapList(dataList);
        finalResponse = SuccessWrapper(data: entity);
    }
    return finalResponse;
  }
}
