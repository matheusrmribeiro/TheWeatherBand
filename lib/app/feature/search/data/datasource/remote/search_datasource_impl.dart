import 'package:weather_band/app/core/api/api_client.dart';
import 'package:weather_band/app/core/api/response_wrapper.dart';
import 'package:weather_band/app/core/constants.dart';

import 'search_datasource_interface.dart';

class SearchDatasourceImpl extends SearchDatasourceInterface {
  final apiGeo = APIClient(baseUrl: kSERVER_BASE_GEO);

  @override
  Future<ResponseWrapper> search(String search) {
    final query = {
      "q": search,
      "limit": 10
    };
    return apiGeo.request(type: RequestType.get, path: "/direct", query: query);
  }
}
