import 'package:e_movie/config/util/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppConfig extends InheritedWidget {
  const AppConfig({
    super.key,
    required Widget child,
  }) : super(child: child);

  static String currentUrl = 'https://api.openweathermap.org/';
  static String apiKey = 'bd3df9d559dd5069b0a7ca1a1312e97a';

  static late bool isDebug;

  static Duration connectTimeout = const Duration(seconds: 100);
  static Duration receiveTimeout = const Duration(seconds: 100);

  static void log(String message) {
    if (kDebugMode) {
      print(Constant.appName + (" : ") + message);
    }
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
