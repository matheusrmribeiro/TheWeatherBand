import 'package:weather_band/app/core/api/response_wrapper.dart';
import 'package:weather_band/app/core/base/base_view_model.dart';
import 'package:weather_band/app/core/base/enum/view_model_state.dart';
import 'package:weather_band/app/core/languages/language_utils.dart';
import 'package:weather_band/app/feature/search/data/repository/geolocation_repository_impl.dart';

import '../domain/entities/geolocation_entity.dart';

class SearchViewModel extends BaseViewModel {
  final GeolocationRepositoryImpl repository = GeolocationRepositoryImpl();

  List<GeolocationEntity> searchResults = [];

  void fetchData(String search) {
    blockLoading(
      message: LanguageUtils.getString("loading_geolocation"),
      block: () async {
        final response = await repository.search(search);

        if (response is SuccessWrapper)
          searchResults = response.data;
        else
          setState(
            ErrorState(message: LanguageUtils.getString("error_geolocation")),
          );

        setState(IdleState());
      },
    );
  }
}
