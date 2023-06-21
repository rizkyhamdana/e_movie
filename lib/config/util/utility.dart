import 'package:dio/dio.dart';
import 'package:e_movie/config/util/constant.dart';

class Utility {
  static String handleError(DioException error) {
    if (error.type == DioExceptionType.cancel) {
      return "Connection failed, please check your network";
    }
    if (error.type == DioExceptionType.connectionTimeout) {
      return "Connection failed, please check your network";
    }
    if (error.type == DioExceptionType.unknown) {
      if (error.error != null) {
        return Utility.handleErrorString(error.error.toString());
      }
      return "Terjadi kesalahan pada server";
    }
    if (error.type == DioExceptionType.receiveTimeout) {
      return "Koneksi timeout saat menerima data dari server";
    }
    if (error.type == DioExceptionType.badResponse) {
      return 'Bad response\n ${error.message}';
    }
    if (error.type == DioExceptionType.sendTimeout) {
      return "Koneksi timeout saat mengirim ke server";
    }

    return "Undefined Error";
  }

  static String handleErrorString(String error, {bool withErrorCode = true}) {
    if (error.contains(Constant.R_TIMEOUT)) {
      return "Session expired";
    } else if (error.contains(Constant.R_SOCKET_EXC)) {
      return "Connection failed,Please check your internet connection";
    } else if (error.contains(Constant.R_SERVICE_UNAVAILABLE)) {
      return "Service Unavailable";
    } else if (error.contains(Constant.R_OTHER_TYPE)) {
      return "An error occurred on the server";
    } else if (error.contains(Constant.R_EXCEPT)) {
      try {
        String errorCode = error.substring(error.indexOf("("), error.length);
        String cleanError = error.substring(0, error.indexOf("(") - 1);
        cleanError = withErrorCode
            ? ("${cleanError.replaceAll(Constant.R_EXCEPT, '').trim()} $errorCode")
            : (cleanError.replaceAll(Constant.R_EXCEPT, '').trim());
        return cleanError;
      } catch (e) {
        return (error.replaceAll(Constant.R_EXCEPT, '').trim());
      }
    } else if (error.contains(Constant.R_RESPONSE)) {
      var message = error.substring(10, error.length);
      message = message.substring(message.indexOf(':') + 1, message.length);

      if (message.toLowerCase().contains('exception')) {
        return message.substring(10, message.length);
      }

      return (message);
    } else {
      return "An error occurred in App";
    }
  }
}
