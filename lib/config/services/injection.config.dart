// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:e_movie/config/helper/api_helper.dart' as _i3;
import 'package:e_movie/config/services/call_api_service.dart' as _i6;
import 'package:e_movie/data/repository/app_repository_impl.dart' as _i5;
import 'package:e_movie/domain/entities/global.dart' as _i7;
import 'package:e_movie/domain/repository/app_repository.dart' as _i4;
import 'package:e_movie/presentation/pages/movie/movie_cubit.dart' as _i8;
import 'package:e_movie/presentation/pages/tv_show/tv_show_cubit.dart' as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.ApiHelper>(() => _i3.ApiHelper());
  gh.lazySingleton<_i4.AppRepository>(() => _i5.AppRepositoryImpl());
  gh.lazySingleton<_i6.CallApiService>(() => _i6.CallApiService());
  gh.lazySingleton<_i7.Global>(() => _i7.Global());
  gh.lazySingleton<_i8.MovieCubit>(() => _i8.MovieCubit());
  gh.lazySingleton<_i9.TvShowCubit>(() => _i9.TvShowCubit());
  return getIt;
}
