import 'package:e_movie/data/model/city.dart';
import 'package:e_movie/data/model/forecast.dart';
import 'package:e_movie/data/model/movie.dart';
import 'package:e_movie/data/model/tv_show.dart';

abstract class AppRepository {
  Future<List<CityResponse>> getCity(String cityName);
  Future<ForecastResponse> getForecast(double lat, double long);
  Future<MovieResponse> getListMovie(String type);
  Future<TvShowResponse> getListTvShow(String type);
}
