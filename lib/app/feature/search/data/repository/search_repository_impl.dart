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
        final dataList = (data as List)
            .map((e) => e as Map<String, dynamic>)
            .toList();
        final entity = CityEntity.fromMapList(dataList);
        finalResponse = SuccessWrapper(data: entity);
    }

    return finalResponse;
  }

  @override
  Future<ResponseWrapper> getBookmarks() async {
    final bookmarks = sharedPreferences.getStringList(SHARED_PREFS_BOOKMARKS) ?? [];
    final bookmarksList = bookmarks.map((e) => CityEntity.fromMap(jsonDecode(e))).toList();
    return SuccessWrapper(data: bookmarksList);
  }

  @override
  void addBookmark(CityEntity city) {
    final bookmarks = sharedPreferences.getStringList(SHARED_PREFS_BOOKMARKS) ?? [];
    bookmarks.add(jsonEncode(city.toMap()));
    sharedPreferences.setStringList(SHARED_PREFS_BOOKMARKS, bookmarks);
  }

  @override
  void removeBookmark(CityEntity city) {
    final bookmarks = sharedPreferences.getStringList(SHARED_PREFS_BOOKMARKS) ?? [];
    bookmarks.removeWhere((element) => element == jsonEncode(city.toMap()));
    sharedPreferences.setStringList(SHARED_PREFS_BOOKMARKS, bookmarks);
  }

}
