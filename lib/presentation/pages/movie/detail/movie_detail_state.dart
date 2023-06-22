import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class MovieDetailState extends Equatable {
  const MovieDetailState();
  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieDetailState {}

class MovieLoading extends MovieDetailState {}

class MovieSaved extends MovieDetailState {}

class MovieDeleted extends MovieDetailState {}

class MovieIsWatchList extends MovieDetailState {}

class MovieIsNotWatchList extends MovieDetailState {}

class MovieError extends MovieDetailState {
  final String error;
  const MovieError({required this.error});
}
