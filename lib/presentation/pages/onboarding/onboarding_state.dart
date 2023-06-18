import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class OnboardingState extends Equatable {
  const OnboardingState();
  @override
  List<Object> get props => [];
}

class OnboardingInitial extends OnboardingState {}

class LocationLoading extends OnboardingState {}

class LocationGet extends OnboardingState {}

class LocationFailed extends OnboardingState {}
