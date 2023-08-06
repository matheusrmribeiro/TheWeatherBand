import 'package:weather_band/app/core/api/response_wrapper.dart';

abstract class GeolocationRepositoryInterface {

  Future<ResponseWrapper> search(String search);

}