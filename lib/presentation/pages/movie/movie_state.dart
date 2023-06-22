import 'package:e_movie/data/model/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class MovieState extends Equatable {
  const MovieState();
  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieSaved extends MovieState {}

class ListMovieLoading extends MovieState {}

class MovieSearchLoading extends MovieState {}

class MovieSearchLoaded extends MovieState {
  final MovieResponse movieResponse;
  const MovieSearchLoaded({required this.movieResponse});
}

class MovieLoaded extends MovieState {
  final MovieResponse movieResponse;
  const MovieLoaded({required this.movieResponse});
}

class ListMovieLoaded extends MovieState {
  final MovieResponse movieResponse;
  const ListMovieLoaded({required this.movieResponse});
}

class MovieEmpty extends MovieState {}

class MovieSearchEmpty extends MovieState {}

class ListMovieEmpty extends MovieState {}

class MovieError extends MovieState {
  final String error;
  const MovieError({required this.error});
}

class MovieSearchError extends MovieState {
  final String error;
  const MovieSearchError({required this.error});
}

class ListMovieError extends MovieState {
  final String error;
  const ListMovieError({required this.error});
}
