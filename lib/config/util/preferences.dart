import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? prefs;

  static void setStringPref(String key, String value) {
    prefs?.setString(key, value);
  }

  static String getStringPref(String key) {
    return prefs?.getString(key).toString() ?? '';
  }

  Future<String?> getStringAs(String key) async {
    return prefs?.getString(key);
  }

  static void getKey() async {
    prefs = await SharedPreferences.getInstance();
  }
}

class PreferencesHelper {
  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  static Future<String?> getString(String key) async {
    final p = await prefs;
    return p.getString(key);
  }

  static Future setString(String key, String value) async {
    final p = await prefs;
    return p.setString(key, value);
  }

  static Future<double> getDouble(String key) async {
    final p = await prefs;
    return p.getDouble(key) ?? 0.0;
  }

  static Future setDouble(String key, double value) async {
    final p = await prefs;
    return p.setDouble(key, value);
  }

  static Future<bool> getBool(String key) async {
    final p = await prefs;
    return p.getBool(key) ?? true;
  }

  static Future<bool?> getBoolNullable(String key) async {
    final p = await prefs;
    return p.getBool(key);
  }

  static Future setBool(String key, bool value) async {
    final p = await prefs;
    return p.setBool(key, value);
  }
}

class Prefs {
  static Future<double> get getLong => PreferencesHelper.getDouble(Const.long);

  static Future setLong(double value) =>
      PreferencesHelper.setDouble(Const.long, value);

  static Future<double> get getLat => PreferencesHelper.getDouble(Const.lat);

  static Future setLat(double value) =>
      PreferencesHelper.setDouble(Const.lat, value);

  static Future<bool> get getFistLaunch =>
      PreferencesHelper.getBool(Const.firstLaunch);

  static Future setFirstLaunch(bool value) =>
      PreferencesHelper.setBool(Const.firstLaunch, value);
}

class Const {
  static const String long = 'Longitude';
  static const String lat = 'Latitude';
  static const String firstLaunch = 'FirstLaunch';
}
