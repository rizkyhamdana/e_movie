import 'package:e_movie/config/services/injection.dart';
import 'package:e_movie/config/util/constant.dart';
import 'package:e_movie/config/util/utility.dart';
import 'package:e_movie/data/model/movie.dart';
import 'package:e_movie/domain/repository/app_repository.dart';
import 'package:e_movie/presentation/pages/movie/detail/movie_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit() : super(MovieInitial());

  var appRepository = getIt<AppRepository>();

  void insertWatchListMovie(Movie movie) async {
    try {
      emit(MovieLoading());
      await appRepository.insertMovie(movie);
      emit(MovieSaved());
    } catch (e) {
      emit(MovieError(error: Utility.handleErrorString(e.toString())));
    }
  }

  void getMovieById(int id) async {
    try {
      emit(MovieLoading());
      var result = await appRepository.getMovieById(id);
      if (result) {
        emit(MovieIsWatchList());
      } else {
        emit(MovieIsNotWatchList());
      }
    } catch (e) {
      emit(MovieError(error: Utility.handleErrorString(e.toString())));
    }
  }

  void deleteMovie(int id) async {
    try {
      emit(MovieLoading());
      await appRepository.deleteMovie(id);
      emit(MovieDeleted());
    } catch (e) {
      emit(MovieError(error: Utility.handleErrorString(e.toString())));
    }
  }
}
