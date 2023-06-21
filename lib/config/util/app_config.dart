import 'package:e_movie/config/util/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppConfig extends InheritedWidget {
  const AppConfig({
    super.key,
    required Widget child,
  }) : super(child: child);

  static String currentUrl = 'https://api.themoviedb.org/3/';
  static String token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MjAwOTMwNzA1ZTk1YmUxODVlMmViNWUzMjczYjUyYSIsInN1YiI6IjYwODY3YjQ5NTMyYWNiMDA3N2VlODkzOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.K-8jjtV3muYN6bxUVH1Q0oWInIDS5q_7sn1TfE9pF9I';

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
