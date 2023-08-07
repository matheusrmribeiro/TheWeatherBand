import 'dart:convert';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_band/app/core/api/response_wrapper.dart';
import 'package:weather_band/app/core/constants.dart';
import 'package:weather_band/app/feature/search/data/datasource/remote/search_datasource_impl.dart';
import 'package:weather_band/app/feature/search/domain/entities/city_entity.dart';
import 'package:weather_band/app/feature/search/domain/repository/search_repository_interface.dart';

class SearchRepositoryImpl extends SearchRepositoryInterface {
  final datasource = SearchDatasourceImpl();
  final sharedPreferences = Modular.get<SharedPreferences>();

  @override
  Future<ResponseWrapper> search(String search) async {
    final response = await datasource.search(search);
    final ResponseWrapper finalResponse;

    switch (response) {
      case ErrorWrapper():
        finalResponse = response;
      case SuccessWrapper(data: var data):
        final dataList =
            (data as List).map((e) => e as Map<String, dynamic>).toList();
        final entity = CityEntity.fromMapList(dataList);
        finalResponse = SuccessWrapper(data: entity);
    }

    return finalResponse;
  }

  @override
  Future<ResponseWrapper> getBookmarks() async {
    await _mockData();
    final bookmarks =
        sharedPreferences.getStringList(SHARED_PREFS_BOOKMARKS) ?? [];
    final bookmarksList =
        bookmarks.map((e) => CityEntity.fromMap(jsonDecode(e))).toList();
    return SuccessWrapper(data: bookmarksList);
  }

  @override
  void addBookmark(CityEntity city) {
    final bookmarks =
        sharedPreferences.getStringList(SHARED_PREFS_BOOKMARKS) ?? [];
    bookmarks.add(jsonEncode(city.toMap()));
    sharedPreferences.setStringList(SHARED_PREFS_BOOKMARKS, bookmarks);
  }

  @override
  void removeBookmark(CityEntity city) {
    final bookmarks =
        sharedPreferences.getStringList(SHARED_PREFS_BOOKMARKS) ?? [];
    bookmarks.removeWhere((element) => element == jsonEncode(city.toMap()));
    sharedPreferences.setStringList(SHARED_PREFS_BOOKMARKS, bookmarks);
  }

  /// Mock first data
  Future<void> _mockData() async {
    const kFIRST_USE = "first_use";
    final firstUse = sharedPreferences.getBool(kFIRST_USE) ?? true;
    if (firstUse) {
      final mockedData = [
        CityEntity(
          name: "Silverstone",
          country: "GB",
          state: "England",
          lat: 52.0877287,
          lon: -1.0241177,
        ),
        CityEntity(
          name: "São Paulo",
          country: "BR",
          state: "São Paulo",
          lat: -23.5506507,
          lon: -46.6333824,
        ),
        CityEntity(
          name: "Melbourne",
          country: "AU",
          state: "Victoria",
          lat: -37.8142176,
          lon: 144.9631608,
        ),
        CityEntity(
          name: "Monte-Carlo",
          country: "MC",
          state: null,
          lat: 43.7402961,
          lon: 7.426559,
        ),
      ].map((e) => jsonEncode(e.toMap())).toList();
      await sharedPreferences.setBool(kFIRST_USE, false);
      await sharedPreferences.setStringList(SHARED_PREFS_BOOKMARKS, mockedData);
    }
  }
}
