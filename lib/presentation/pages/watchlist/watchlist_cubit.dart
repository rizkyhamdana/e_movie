import 'package:flutter_bloc/flutter_bloc.dart';

import 'watchlist_state.dart';

class WatchlistCubit extends Cubit<WatchlistState> {
  WatchlistCubit() : super(WatchlistState().init());
}
