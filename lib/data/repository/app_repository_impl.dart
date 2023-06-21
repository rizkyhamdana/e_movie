import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e_movie/data/model/movie.dart';
import 'package:e_movie/data/model/tv_show.dart';
import 'package:injectable/injectable.dart';
import 'package:e_movie/config/services/call_api_service.dart';
import 'package:e_movie/config/services/injection.dart';
import 'package:e_movie/config/util/constant.dart';
import 'package:e_movie/config/util/utility.dart';
import 'package:e_movie/data/model/city.dart';
import 'package:e_movie/data/model/forecast.dart';
import 'package:e_movie/domain/repository/app_repository.dart';

@LazySingleton(as: AppRepository)
class AppRepositoryImpl implements AppRepository {
  var callService = getIt<CallApiService>();
  @override
  Future<List<CityResponse>> getCity(String cityName) async {
    try {
      var response = await callService.connect(
        Constant.getCity,
        {
          "q": cityName,
        },
        Constant.get,
      );

      return cityResponseFromJson(jsonEncode(response.data));
    } on DioException catch (e) {
      throw Exception(Utility.handleError(e));
    }
  }

  @override
  Future<ForecastResponse> getForecast(double lat, double long) async {
    try {
      var response = await callService.connect(
        Constant.getForecast,
        {
          "lat": lat,
          "lon": long,
        },
        Constant.get,
      );

      return forecastResponseFromJson(jsonEncode(response.data));
    } on DioException catch (e) {
      throw Exception(Utility.handleError(e));
    }
  }

  @override
  Future<MovieResponse> getListMovie(String type) async {
    try {
      var path = Constant.getMoviePopular;
      switch (type) {
        case Constant.MOVPOPULAR:
          path = Constant.getMoviePopular;
          break;
        case Constant.MOVNOWPLAYING:
          path = Constant.getMovieNowPlaying;
          break;
        case Constant.MOVTOPRATED:
          path = Constant.getMovieTopRated;
          break;
        case Constant.MOVUPCOMING:
          path = Constant.getMovieUpcoming;
          break;

        default:
          break;
      }
      var response = await callService.connect(
        path,
        {},
        Constant.get,
      );

      return movieResponseFromJson(jsonEncode(response.data));
    } on DioException catch (e) {
      throw Exception(Utility.handleError(e));
    }
  }

  @override
  Future<TvShowResponse> getListTvShow(String type) async {
    try {
      var path = Constant.getTvPopular;
      switch (type) {
        case Constant.TVPOPULAR:
          path = Constant.getTvPopular;
        case Constant.TVAIRING:
          path = Constant.getTvAiring;
        case Constant.TVONTHEAIR:
          path = Constant.getTvOnTheAir;
        case Constant.TVTOPRATED:
          path = Constant.getTvTopRated;
          break;
        default:
          break;
      }
      var response = await callService.connect(
        path,
        {},
        Constant.get,
      );

      return tvShowResponseFromJson(jsonEncode(response.data));
    } on DioException catch (e) {
      throw Exception(Utility.handleError(e));
    }
  }
}
