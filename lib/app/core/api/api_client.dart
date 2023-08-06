import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_band/app/core/api/response_wrapper.dart';

import '../constants.dart';

enum RequestType { get, put, post, delete, patch }

class APIClient {
  APIClient({String? baseUrl}) {
    _dio = _buildDio(baseUrl);
  }

  final SharedPreferences prefs = Modular.get<SharedPreferences>();
  late Dio _dio;

  Dio _buildDio(String? baseUrl) {
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    var options = BaseOptions(
      baseUrl: baseUrl ?? kSERVER_BASE,
      connectTimeout: Duration(milliseconds: 5000),
      receiveTimeout: Duration(milliseconds: 3000),
      headers: headers,
    );

    Dio dio = Dio(options);
    return dio;
  }

  Future<ResponseWrapper> request({
    required RequestType type,
    required String path,
    Map<String, dynamic> data = const {},
    Map<String, dynamic> query = const {},
  }) async {
    query["appid"] = kAPI_KEY;
    try {
      Response<dynamic> response;
      switch (type) {
        case RequestType.get:
          response = await _dio.get(path, queryParameters: query);
          break;
        case RequestType.put:
          response = await _dio.put(path, data: data, queryParameters: query);
          break;
        case RequestType.post:
          response = await _dio.post(path, data: data, queryParameters: query);
          break;
        case RequestType.delete:
          response =
              await _dio.delete(path, data: data, queryParameters: query);
          break;
        case RequestType.patch:
          response =
              await _dio.patch(path, data: data, queryParameters: query);
          break;
      }

      _printRequestLog(type, response);

      if (response.statusCode == 200)
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
