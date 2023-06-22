import 'package:e_movie/config/services/injection.dart';
import 'package:e_movie/config/util/constant.dart';
import 'package:e_movie/config/util/utility.dart';
import 'package:e_movie/domain/repository/app_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'tv_show_state.dart';

@lazySingleton
class TvShowCubit extends Cubit<TvShowState> {
  TvShowCubit() : super(TvShowInitial());

  var appRepository = getIt<AppRepository>();

  void closeCubit() {
    close();
  }

  void getTopListTvShow() async {
    try {
      emit(TvShowLoading());
      var response = await appRepository.getListTvShow(Constant.TVTOPRATED);
      if (response.results!.isEmpty) {
        emit(TvShowEmpty());
      } else {
        emit(TvShowLoaded(tvShowResponse: response));
      }
    } catch (e) {
      emit(TvShowError(error: Utility.handleErrorString(e.toString())));
    }
  }

  void getListTvShow(String type) async {
    try {
      emit(ListTvShowLoading());
      var response = await appRepository.getListTvShow(type);
      if (response.results!.isEmpty) {
        emit(ListTvShowEmpty());
      } else {
        emit(ListTvShowLoaded(tvShowResponse: response));
      }
    } catch (e) {
      emit(ListTvShowError(error: Utility.handleErrorString(e.toString())));
    }
  }
}
