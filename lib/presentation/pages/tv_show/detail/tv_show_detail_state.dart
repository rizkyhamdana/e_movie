import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class TvShowDetailState extends Equatable {
  const TvShowDetailState();
  @override
  List<Object> get props => [];
}

class TvShowInitial extends TvShowDetailState {}

class TvShowLoading extends TvShowDetailState {}

class TvShowSaved extends TvShowDetailState {}

class TvShowDeleted extends TvShowDetailState {}

class TvShowIsWatchList extends TvShowDetailState {}

class TvShowIsNotWatchList extends TvShowDetailState {}

class TvShowError extends TvShowDetailState {
  final String error;
  const TvShowError({required this.error});
}
