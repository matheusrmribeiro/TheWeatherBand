import 'package:weather_band/app/core/api/response_wrapper.dart';
import 'package:weather_band/app/feature/search/domain/entities/city_entity.dart';

abstract class SearchRepositoryInterface {

  /// Get Search
  ///
  /// Params
  ///   - [search] - A string with format {city name},{state code},{country code}
  ///
  /// Returns a list of matched cities.
  ///
  Future<ResponseWrapper> search(String search);

  /// Add Bookmark
  ///
  /// Params
  ///   - [city] - The city entity.
  ///
  /// Saves locally the bookmarked city.
  ///
  void addBookmark(CityEntity city);

  /// Remove Bookmark
  ///
  /// Params
  ///   - [city] - The city entity.
  ///
  /// Remove locally the bookmarked city.
  ///
  void removeBookmark(CityEntity city);

  /// Get Bookmark
  ///
  /// Fetches all the bookmarked cities.
  ///
  Future<ResponseWrapper> getBookmarks();

}