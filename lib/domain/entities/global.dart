import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class Global {
  String? languageId;
  int appSessionTimeout = 300;
  bool appSessionEnabled = false;
  CancelToken cancelToken = CancelToken();
}
