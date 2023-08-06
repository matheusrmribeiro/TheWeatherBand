import 'package:weather_band/app/core/api/response_wrapper.dart';

abstract class SearchDatasourceInterface {

  Future<ResponseWrapper> search(String search);

}