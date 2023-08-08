import 'package:weather_band/app/core/api/response_wrapper.dart';

abstract class SearchDatasourceInterface {

  /// Get Search
  ///
  /// Params
  ///   - [search] - A string with format {city name},{state code},{country code}
  ///
  /// Returns a list of matched cities.
  ///
  Future<ResponseWrapper> search(String search);

}