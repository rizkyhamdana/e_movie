import 'package:e_movie/data/model/movie.dart';
import 'package:e_movie/data/model/tv_show.dart';

abstract class AppRepository {
  Future<MovieResponse> getListMovie(String type);
  Future<MovieResponse> getListSearchMovie(String query);
  Future<TvShowResponse> getListTvShow(String type);
  Future<TvShowResponse> getListSearchTvShow(String query);
}
