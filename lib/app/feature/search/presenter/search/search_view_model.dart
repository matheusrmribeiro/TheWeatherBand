import 'package:weather_band/app/core/api/response_wrapper.dart';
import 'package:weather_band/app/core/base/base_view_model.dart';
import 'package:weather_band/app/core/base/enum/view_model_state.dart';
import 'package:weather_band/app/core/languages/language_utils.dart';
import 'package:weather_band/app/feature/search/data/repository/search_repository_impl.dart';

import '../../domain/entities/city_entity.dart';

class SearchViewModel extends BaseViewModel {
  final SearchRepositoryImpl repository = SearchRepositoryImpl();

  List<CityEntity> searchResults = [];

  void fetchFromServer(String search) {
    if (search.isEmpty) {
      searchResults = [];
      notifyListeners();
    } else {
      blockLoading(
        message: LanguageUtils.getString("loading_geolocation"),
        block: () async {
          final response = await repository.search(search);

          if (response is SuccessWrapper) {
            searchResults = response.data;
            setState(IdleState());
          } else
            setState(
              ErrorState(message: LanguageUtils.getString("error_geolocation")),
            );
        },
      );
    }
  }

  void addBookmark(CityEntity city) {
    repository.addBookmark(city);
  }
}
