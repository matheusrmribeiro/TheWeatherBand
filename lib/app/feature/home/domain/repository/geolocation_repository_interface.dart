import 'package:weather_band/app/core/api/response_wrapper.dart';
import 'package:weather_band/app/feature/home/data/model/request/geo_point_request.dart';

abstract class GeolocationRepositoryInterface {

  Future<ResponseWrapper> search(String search);

}