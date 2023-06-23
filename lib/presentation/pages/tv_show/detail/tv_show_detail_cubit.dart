import 'package:e_movie/config/services/injection.dart';
import 'package:e_movie/config/util/utility.dart';
import 'package:e_movie/data/model/tv_show.dart';
import 'package:e_movie/domain/repository/app_repository.dart';
import 'package:e_movie/presentation/pages/tv_show/detail/tv_show_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class TvShowDetailCubit extends Cubit<TvShowDetailState> {
  TvShowDetailCubit() : super(TvShowInitial());

  var appRepository = getIt<AppRepository>();

  void insertWatchListTvShow(TvShow tvShow) async {
    try {
      emit(TvShowLoading());
      await appRepository.insertTvShow(tvShow);
      emit(TvShowSaved());
    } catch (e) {
      emit(TvShowError(error: Utility.handleErrorString(e.toString())));
    }
  }

  void getTvShowById(int id) async {
    try {
      emit(TvShowLoading());
      var result = await appRepository.getTvShowById(id);
      if (result) {
        emit(TvShowIsWatchList());
      } else {
        emit(TvShowIsNotWatchList());
      }
    } catch (e) {
      emit(TvShowError(error: Utility.handleErrorString(e.toString())));
    }
  }

  void deleteTvShow(int id) async {
    try {
      emit(TvShowLoading());
      await appRepository.deleteTvShow(id);
      emit(TvShowDeleted());
    } catch (e) {
      emit(TvShowError(error: Utility.handleErrorString(e.toString())));
    }
  }
}
