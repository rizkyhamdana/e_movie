import 'package:e_movie/config/services/injection.dart';
import 'package:e_movie/config/util/utility.dart';
import 'package:e_movie/domain/repository/app_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'watchlist_state.dart';

@lazySingleton
class WatchListCubit extends Cubit<WatchListState> {
  WatchListCubit() : super(WatchListInitial());

  var appRepository = getIt<AppRepository>();

  void getWatchListMovie() async {
    try {
      emit(WatchListMovieLoading());
      var result = await appRepository.getMovieWatchlist();
      if (result.isEmpty) {
        emit(WatchListMovieEmpty());
      } else {
        emit(WatchListMovieLoaded(listMovie: result));
      }
    } catch (e) {
      emit(WatchListMovieError(error: Utility.handleErrorString(e.toString())));
    }
  }

  void getWatchListTvShow() async {
    try {
      emit(WatchListTvShowLoading());
      var result = await appRepository.getTvShowWatchList();
      if (result.isEmpty) {
        emit(WatchListTvShowEmpty());
      } else {
        emit(WatchListTvShowLoaded(listTvShow: result));
      }
    } catch (e) {
      emit(
          WatchListTvShowError(error: Utility.handleErrorString(e.toString())));
    }
  }
}
