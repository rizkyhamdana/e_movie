import 'package:e_movie/data/model/city.dart';
import 'package:e_movie/data/model/forecast.dart';

abstract class AppRepository {
  Future<List<CityResponse>> getCity(String cityName);
  Future<ForecastResponse> getForecast(double lat, double long);
}
