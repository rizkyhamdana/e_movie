import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:e_movie/data/model/city.dart';
import 'package:e_movie/data/model/forecast.dart';

@immutable
class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final CityResponse cityResponse;
  const HomeLoaded({required this.cityResponse});
}

class HomeForecastLoaded extends HomeState {
  final ForecastResponse forecastResponse;
  const HomeForecastLoaded({required this.forecastResponse});
}

class HomeError extends HomeState {
  final String error;
  const HomeError({required this.error});
}

class HomeEmpty extends HomeState {}
