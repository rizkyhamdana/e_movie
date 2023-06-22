import 'package:e_movie/config/services/injection.dart';
import 'package:e_movie/domain/repository/app_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'watchlist_state.dart';

@lazySingleton
class WatchListCubit extends Cubit<WatchListState> {
  WatchListCubit() : super(WatchListInitial());

  var appRepository = getIt<AppRepository>();
}
