import 'package:e_movie/config/services/injection.dart';
import 'package:e_movie/config/util/utility.dart';
import 'package:e_movie/domain/repository/app_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'movie_state.dart';

@lazySingleton
class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(MovieInitial());

  var appRepository = getIt<AppRepository>();

  void closeCubit() {
    close();
  }

  void getListMovie(String type) async {
    try {
      emit(MovieLoading());
      var response = await appRepository.getListMovie(type);
      if (response.results!.isEmpty) {
        emit(MovieEmpty());
      } else {
        emit(MovieLoaded(movieResponse: response));
      }
    } catch (e) {
      emit(MovieError(error: Utility.handleErrorString(e.toString())));
    }
  }
}
