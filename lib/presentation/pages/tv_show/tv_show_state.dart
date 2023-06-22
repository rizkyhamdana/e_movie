import 'package:e_movie/data/model/tv_show.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class TvShowState extends Equatable {
  const TvShowState();
  @override
  List<Object> get props => [];
}

class TvShowInitial extends TvShowState {}

class TvShowLoading extends TvShowState {}

class TvShowSearchLoading extends TvShowState {}

class ListTvShowLoading extends TvShowState {}

class TvShowLoaded extends TvShowState {
  final TvShowResponse tvShowResponse;
  const TvShowLoaded({required this.tvShowResponse});
}

class TvShowSearchLoaded extends TvShowState {
  final TvShowResponse tvShowResponse;
  const TvShowSearchLoaded({required this.tvShowResponse});
}

class ListTvShowLoaded extends TvShowState {
  final TvShowResponse tvShowResponse;
  const ListTvShowLoaded({required this.tvShowResponse});
}

class TvShowEmpty extends TvShowState {}

class TvShowSearchEmpty extends TvShowState {}

class ListTvShowEmpty extends TvShowState {}

class TvShowError extends TvShowState {
  final String error;
  const TvShowError({required this.error});
}

class TvShowSearchError extends TvShowState {
  final String error;
  const TvShowSearchError({required this.error});
}

class ListTvShowError extends TvShowState {
  final String error;
  const ListTvShowError({required this.error});
}
