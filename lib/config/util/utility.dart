import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:e_movie/config/util/constant.dart';
import 'package:e_movie/config/util/preferences.dart';

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

  static String getWeatherImage(String weatherIcon) {
    switch (weatherIcon) {
      case ConstantWeather.CLEAR || ConstantWeather.CLEAR2:
        return 'ic_clearsky';
      case ConstantWeather.FEWCLOUDS || ConstantWeather.FEWCLOUDS2:
        return 'ic_fewcloud';
      case ConstantWeather.SCATTEREDCLOUDS || ConstantWeather.SCATTEREDCLOUDS2:
        return 'ic_scatteredcloud';
      case ConstantWeather.BROKENCLOUDS || ConstantWeather.BROKENCLOUDS2:
        return 'ic_brokencloud';
      case ConstantWeather.SHOWERRAIN || ConstantWeather.SHOWERRAIN2:
        return 'ic_showerrain';
      case ConstantWeather.RAIN || ConstantWeather.RAIN2:
        return 'ic_rain';
      case ConstantWeather.THUNDERSTORM || ConstantWeather.THUNDERSTORM2:
        return 'ic_thunderstorm';
      case ConstantWeather.SNOW || ConstantWeather.SNOW2:
        return 'ic_clearsky';
      case ConstantWeather.MIST || ConstantWeather.MIST2:
        return 'ic_clearsky';
      default:
        return 'ic_clearsky';
    }
  }

  static String getWeatherImages(int idWeather) {
    if (idWeather < 300) {
      return 'ic_thunderstorm';
    }
    if (idWeather < 400) {
      return 'ic_showerrain';
    }
    if (idWeather < 600) {
      return 'ic_rain';
    }
    if (idWeather < 700) {
      return 'ic_snow';
    }
    if (idWeather < 800) {
      return 'ic_mist';
    }
    if (idWeather == 800) {
      return 'ic_clearsky';
    }
    if (idWeather == 801) {
      return 'ic_fewcloud';
    }
    if (idWeather == 802) {
      return 'ic_scatteredcloud';
    }
    if (idWeather > 802) {
      return 'ic_brokencloud';
    }

    return 'ic_clearsky';
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

  static Future<bool> getUserLocation() async {
    try {
      PermissionStatus permissionGranted;

      permissionGranted = await Permission.location.request();

      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await Permission.location.request();
        return false;
      }
      if (permissionGranted == PermissionStatus.granted) {
        try {
          var location = await Geolocator.getCurrentPosition();
          await Prefs.setLat(location.latitude);
          await Prefs.setLong(location.longitude);
          return true;
        } catch (e) {
          return false;
        }
      }
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
