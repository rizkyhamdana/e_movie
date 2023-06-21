import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:e_movie/config/services/interceptor.dart';
import 'package:e_movie/config/util/app_config.dart';

@lazySingleton
class ApiHelper {
  late Dio dio;

  ApiHelper() {
    dio = Dio();
    dio.options.baseUrl = AppConfig.currentUrl;
    dio.options.connectTimeout = AppConfig.connectTimeout;

    dio.options.receiveTimeout = AppConfig.receiveTimeout;
    dio.options.responseType = ResponseType.json;
    dio.interceptors.add(AppInterceptors());
  }

  Future<Response<T>> post<T>(String url, Map<String, dynamic> data,
      CancelToken cancelToken, Map<String, dynamic>? extra) {
    dio.options.extra = extra ?? {};
    return dio.post(url, data: data, cancelToken: cancelToken);
  }

  Future<Response<T>> get<T>(String url, Map<String, dynamic> data,
      CancelToken cancelToken, Map<String, dynamic>? extra) {
    dio.options.extra = extra ?? {};

    return dio.get(url, queryParameters: data, cancelToken: cancelToken);
  }

  Future<Response<T>> upload<T>(String url, FormData data,
      CancelToken cancelToken, Map<String, dynamic>? extra) {
    dio.options.extra = extra ?? {};
    return dio.post(url, data: data, cancelToken: cancelToken);
  }

  Future<Response> download<T>(String url, String savingPath,
      Function(int, int) progress, CancelToken cancelToken) {
    return dio.download(url, savingPath,
        onReceiveProgress: progress, cancelToken: cancelToken);
  }
}
