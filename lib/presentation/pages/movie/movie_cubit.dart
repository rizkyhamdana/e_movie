import 'package:flutter_bloc/flutter_bloc.dart';

import 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(MovieState().init());
}
