import 'package:weather_band/app/core/utils/helper/cities/cities_by_uf_entity.dart';
import 'package:weather_band/app/core/utils/helper/cities/city_entity.dart';

import 'cities_api_map.dart';

class CityHelper {
  static List<CityEntity> data = citiesMap.map((e) => CityEntity.mapper(e)!).toList();

  static List<String> fetchAllUf() => data.map((e) => e.uf).toSet().toList()..sort((a, b) => a.compareTo(b));

  static Map<String, String> fetchAllUfAsMap() {
    final Map<String, String> ufsMap = {};
    final ufs = data.map((e) => e.uf).toSet().toList()..sort((a, b) => a.compareTo(b));
    for (final uf in ufs) {
      ufsMap[uf] = uf;
    }
    return ufsMap;
  }

  static List<CityEntity> fetchByUf(String uf) {
    return data.where((element) => element.uf == uf).toSet().toList();
  }

  static List<CityEntity> fetchByUfToSelect(String uf) {
    final cities = data.where((element) => element.uf == uf).toSet().toList()..sort((a, b) => a.name.compareTo(b.name));
    return cities;
  }

  static List<CityEntity> fetchByCitiesToSelect(String name) {
    final cities = data.where((element) => element.name.startsWith(name)).toSet().toList()..sort((a, b) => a.name.compareTo(b.name));
    return cities;
  }

  static CitiesByUf fetchByUfToSelectOLD(String uf) {
    final cities = data.where((element) => element.uf == uf).toSet().toList()..sort((a, b) => a.name.compareTo(b.name));
    final citiesMap = <int, String>{};
    for (var element in cities) {
      citiesMap[element.id] = element.name;
    }
    return CitiesByUf(
      cities: cities,
      citiesMap: citiesMap
    );
  }

  static String cityToString(CityEntity? entity) {
    if (entity == null)
      return "";
    else {
      return "${entity.uf} - ${entity.name}";
    }
  }

}