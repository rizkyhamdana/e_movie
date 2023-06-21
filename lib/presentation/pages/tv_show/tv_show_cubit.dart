import 'package:flutter_bloc/flutter_bloc.dart';

import 'tv_show_state.dart';

class TvShowCubit extends Cubit<TvShowState> {
  TvShowCubit() : super(TvShowState().init());
}
