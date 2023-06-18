import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:e_movie/config/util/utility.dart';
import 'package:e_movie/presentation/pages/onboarding/onboarding_state.dart';

@lazySingleton
class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  void getLocation() async {
    try {
      emit(LocationLoading());
      var response = await Utility.getUserLocation();
      if (response == true) {
        emit(LocationGet());
      } else {
        emit(LocationFailed());
      }
    } catch (e) {
      emit(LocationFailed());
    }
  }
}
