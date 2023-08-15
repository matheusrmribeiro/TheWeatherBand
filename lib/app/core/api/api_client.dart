import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_band/app/core/api/response_wrapper.dart';

import '../constants.dart';

enum RequestType { get, put, post, delete, patch }

class APIClient {
  APIClient({this.baseUrl});

  final String? baseUrl;
  final SharedPreferences prefs = Modular.get<SharedPreferences>();
  Dio? _dio;
  CacheOptions? cacheOptions;

  Future<Dio> _buildDio(String? baseUrl) async {
    if (_dio != null) return _dio!;

    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    var options = BaseOptions(
      baseUrl: baseUrl ?? kSERVER_BASE,
      connectTimeout: Duration(milliseconds: 15000),
      receiveTimeout: Duration(milliseconds: 13000),
      headers: headers,
    );

    Dio dio = Dio(options);

    final tempDir = await getTemporaryDirectory();
    final CacheStore cacheStore = HiveCacheStore(
      tempDir.path,
      hiveBoxName: "the_weather_band",
    );

    cacheOptions = CacheOptions(
      store: cacheStore,
      policy: CachePolicy.forceCache,
      priority: CachePriority.high,
      maxStale: const Duration(days: 1),
      hitCacheOnErrorExcept: [],
      keyBuilder: (request) {
        return request.uri.toString();
      },
      allowPostMethod: false,
    );

    dio.interceptors.add(DioCacheInterceptor(options: cacheOptions!));

    return dio;
  }

  Future<ResponseWrapper> request({
    required RequestType type,
    required String path,
    Map<String, dynamic> data = const {},
    Map<String, dynamic> query = const {}
  }) async {
    final dio = await _buildDio(baseUrl);

    query["appid"] = kAPI_KEY;
    try {
      Response<dynamic> response;
      switch (type) {
        case RequestType.get:
          response =
              await dio.get(path, queryParameters: query, options: cacheOptions!.toOptions());
          break;
        case RequestType.put:
          response = await dio.put(path,
              data: data, queryParameters: query);
          break;
        case RequestType.post:
          response = await dio.post(path,
              data: data, queryParameters: query);
          break;
        case RequestType.delete:
          response = await dio.delete(path,
              data: data, queryParameters: query);
          break;
        case RequestType.patch:
          response = await dio.patch(path,
              data: data, queryParameters: query);
          break;
      }

      _printRequestLog(type, response);

      if ([200, 304].contains(response.statusCode))
        return SuccessWrapper(data: response.data);
      else {
        return _buildErrorWrapper(
          response,
          response.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      _printErrorLog(e);
      return _buildErrorWrapper(
        e.response,
        e.response?.statusCode.toString(),
      );
    }
  }

  /// Auxiliary methods
  ErrorWrapper _buildErrorWrapper(Response<dynamic>? response, String? tag) {
    return ErrorWrapper(
      errorResponse: ResponseError(
        errorMessage: _handleErrorMessage(response),
        errorTag: tag,
      ),
    );
  }

  String _handleErrorMessage(Response<dynamic>? response) {
    String message = "";
    if (response != null) {
      message = response.statusMessage ?? "";

      if ((message == "") && (response.data is Map<String, dynamic>)) {
        if (response.data.containsKey("error")) {
          message = response.data["error"];
        }
      }
    }
    return message;
  }

  void _printRequestLog(RequestType type, Response<dynamic> response) {
    if (kDebugMode) {
      print("URL -> $type ${response.realUri}");
      print(
          "StatusCode: ${response.statusCode}, StatusMessage: ${_handleErrorMessage(response)}");
      print("Response -> ${response.data}");
    }
  }

  void _printErrorLog(DioException e) {
    if (kDebugMode) {
      print(
          "StatusCode: ${e.response?.statusCode}, StatusMessage: ${_handleErrorMessage(e.response)}");
    }
  }
}
