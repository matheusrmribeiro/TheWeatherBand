import 'package:weather_band/app/core/api/response_wrapper.dart';
import 'package:weather_band/app/feature/search/domain/entities/city_entity.dart';

abstract class SearchRepositoryInterface {

  Future<ResponseWrapper> search(String search);

  void addBookmark(CityEntity city);

  void removeBookmark(CityEntity city);

  Future<ResponseWrapper> getBookmarks();

}