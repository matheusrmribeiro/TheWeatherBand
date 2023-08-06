import 'package:weather_band/app/core/api/response_wrapper.dart';
import 'package:weather_band/app/core/base/base_view_model.dart';
import 'package:weather_band/app/core/base/enum/view_model_state.dart';
import 'package:weather_band/app/core/languages/language_utils.dart';
import 'package:weather_band/app/feature/search/data/repository/search_repository_impl.dart';

import '../../domain/entities/city_entity.dart';

class BookmarkViewModel extends BaseViewModel {
  final SearchRepositoryImpl repository = SearchRepositoryImpl();

  List<CityEntity> bookmarks = [];

  void fetchBookmarks() {
    blockLoading(
      message: LanguageUtils.getString("search_bookmark_fetching"),
      block: () async {
        final response = await repository.getBookmarks();

        if (response is SuccessWrapper)
          bookmarks = response.data;
        else
          setState(
            ErrorState(message: LanguageUtils.getString("error_geolocation")),
          );

        setState(IdleState());
      },
    );
  }

}
