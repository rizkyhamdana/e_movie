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

class MovieLoaded extends MovieState {
  final MovieResponse movieResponse;
  const MovieLoaded({required this.movieResponse});
}

class MovieEmpty extends MovieState {}

class MovieError extends MovieState {
  final String error;
  const MovieError({required this.error});
}
