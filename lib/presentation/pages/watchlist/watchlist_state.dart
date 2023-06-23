import 'package:e_movie/data/model/movie.dart';
import 'package:e_movie/data/model/tv_show.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class WatchListState extends Equatable {
  const WatchListState();
  @override
  List<Object> get props => [];
}

class WatchListInitial extends WatchListState {}

class WatchListMovieLoading extends WatchListState {}

class WatchListMovieEmpty extends WatchListState {}

class WatchListTvShowEmpty extends WatchListState {}

class WatchListMovieLoaded extends WatchListState {
  final List<Movie> listMovie;
  const WatchListMovieLoaded({required this.listMovie});
}

class WatchListMovieError extends WatchListState {
  final String error;
  const WatchListMovieError({required this.error});
}

class WatchListTvShowLoading extends WatchListState {}

class WatchListTvShowLoaded extends WatchListState {
  final List<TvShow> listTvShow;
  const WatchListTvShowLoaded({required this.listTvShow});
}

class WatchListTvShowError extends WatchListState {
  final String error;
  const WatchListTvShowError({required this.error});
}
