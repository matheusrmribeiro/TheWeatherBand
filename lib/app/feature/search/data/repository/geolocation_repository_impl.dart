import 'package:weather_band/app/core/api/response_wrapper.dart';
import 'package:weather_band/app/feature/search/data/datasource/remote/search_datasource_impl.dart';
import 'package:weather_band/app/feature/search/domain/entities/geolocation_entity.dart';
import 'package:weather_band/app/feature/search/domain/repository/geolocation_repository_interface.dart';

class GeolocationRepositoryImpl extends GeolocationRepositoryInterface {
  final datasource = SearchDatasourceImpl();

  @override
  Future<ResponseWrapper> search(String search) async {
    final response = await datasource.search(search);
    final ResponseWrapper finalResponse;

    switch (response) {
      case ErrorWrapper():
        finalResponse = response;
      case SuccessWrapper(data: var data):
        final dataList = (data as List)
            .map((e) => e as Map<String, dynamic>)
            .toList();
        final entity = GeolocationEntity.fromMapList(dataList);
        finalResponse = SuccessWrapper(data: entity);
    }

    return finalResponse;
  }

}
