import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_json/pretty_json.dart';
import 'package:e_movie/config/util/app_config.dart';

class AppInterceptors extends InterceptorsWrapper {
  Response? tempResponse;

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['Authorization'] = "Bearer ${AppConfig.token}";

    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    tempResponse = response;

    if (response.requestOptions.data is FormData) {
      if (kDebugMode) {
        try {
          print(
              'request filed : ${(response.requestOptions.data as FormData).fields.toList()}');
          print(
              'request files : ${(response.requestOptions.data as FormData).files.toList()}');
        } catch (e) {
          print(e);
        }
      }
    }

    if (AppConfig.isDebug) {
      log(
        "===============================================\n"
        "URL : ${response.requestOptions.uri}\n"
        "Headers : ${prettyJson(response.requestOptions.headers)}\n"
        "REQUEST : ${response.requestOptions.data is FormData ? '' : prettyJson(response.requestOptions.data ?? response.requestOptions.queryParameters ?? '')}\n"
        "RESPONSE : ${response.data is ResponseBody ? response.data : prettyJson(response.data)}\n"
        "===============================================",
      );
    }

    if (response.data is Map<String, dynamic> ||
        response.data is List<dynamic>) {
      try {
        return super.onResponse(response, handler);
      } on DioException catch (e) {
        handler.reject(e, false);
      }
    }
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (AppConfig.isDebug) {
      try {
        log(
          "===============================================\n"
          "URL : ${err.requestOptions.uri}\n"
          "Headers : ${prettyJson(err.requestOptions.headers)}\n"
          "REQUEST : ${err.requestOptions.data is FormData ? (err.requestOptions.data as FormData).fields.toList() : prettyJson(err.requestOptions.data ?? err.requestOptions.queryParameters ?? '')}\n"
          "RESPONSE error : ${err.response is ResponseBody ? (err.response as ResponseBody) : prettyJson(
              err.response != null ? err.response?.data["message"] ?? '' : '',
            )}\n"
          "===============================================",
        );
      } catch (e) {
        e.toString();
      }
    }

    handler.reject(err);
  }
}
