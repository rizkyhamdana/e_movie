// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:e_movie/data/model/movie.dart' as _i10;
import 'package:e_movie/data/model/tv_show.dart' as _i11;
import 'package:e_movie/presentation/pages/home/home_view.dart' as _i1;
import 'package:e_movie/presentation/pages/movie/detail/movie_detail_view.dart'
    as _i6;
import 'package:e_movie/presentation/pages/movie/movie_view.dart' as _i2;
import 'package:e_movie/presentation/pages/splashscreen/splash_screen_view.dart'
    as _i4;
import 'package:e_movie/presentation/pages/tv_show/detail/tv_show_detail_view.dart'
    as _i7;
import 'package:e_movie/presentation/pages/tv_show/tv_show_view.dart' as _i3;
import 'package:e_movie/presentation/pages/watchlist/watchlist_view.dart'
    as _i5;
import 'package:flutter/material.dart' as _i9;

abstract class $AppRouter extends _i8.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    HomePage.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
      );
    },
    MoviePage.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.MoviePage(),
      );
    },
    TvShowPage.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.TvShowPage(),
      );
    },
    SplashRoutePage.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SplashScreenPage(),
      );
    },
    WatchlistPage.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.WatchlistPage(),
      );
    },
    MovieDetailPage.name: (routeData) {
      final args = routeData.argsAs<MovieDetailPageArgs>();
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.MovieDetailPage(
          key: args.key,
          movie: args.movie,
          fromWatchList: args.fromWatchList,
        ),
      );
    },
    TvShowDetailPage.name: (routeData) {
      final args = routeData.argsAs<TvShowDetailPageArgs>();
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.TvShowDetailPage(
          key: args.key,
          tvShow: args.tvShow,
          fromWatchList: args.fromWatchList,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.HomePage]
class HomePage extends _i8.PageRouteInfo<void> {
  const HomePage({List<_i8.PageRouteInfo>? children})
      : super(
          HomePage.name,
          initialChildren: children,
        );

  static const String name = 'HomePage';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i2.MoviePage]
class MoviePage extends _i8.PageRouteInfo<void> {
  const MoviePage({List<_i8.PageRouteInfo>? children})
      : super(
          MoviePage.name,
          initialChildren: children,
        );

  static const String name = 'MoviePage';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i3.TvShowPage]
class TvShowPage extends _i8.PageRouteInfo<void> {
  const TvShowPage({List<_i8.PageRouteInfo>? children})
      : super(
          TvShowPage.name,
          initialChildren: children,
        );

  static const String name = 'TvShowPage';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i4.SplashScreenPage]
class SplashRoutePage extends _i8.PageRouteInfo<void> {
  const SplashRoutePage({List<_i8.PageRouteInfo>? children})
      : super(
          SplashRoutePage.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoutePage';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i5.WatchlistPage]
class WatchlistPage extends _i8.PageRouteInfo<void> {
  const WatchlistPage({List<_i8.PageRouteInfo>? children})
      : super(
          WatchlistPage.name,
          initialChildren: children,
        );

  static const String name = 'WatchlistPage';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i6.MovieDetailPage]
class MovieDetailPage extends _i8.PageRouteInfo<MovieDetailPageArgs> {
  MovieDetailPage({
    _i9.Key? key,
    required _i10.Movie movie,
    bool fromWatchList = false,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          MovieDetailPage.name,
          args: MovieDetailPageArgs(
            key: key,
            movie: movie,
            fromWatchList: fromWatchList,
          ),
          initialChildren: children,
        );

  static const String name = 'MovieDetailPage';

  static const _i8.PageInfo<MovieDetailPageArgs> page =
      _i8.PageInfo<MovieDetailPageArgs>(name);
}

class MovieDetailPageArgs {
  const MovieDetailPageArgs({
    this.key,
    required this.movie,
    this.fromWatchList = false,
  });

  final _i9.Key? key;

  final _i10.Movie movie;

  final bool fromWatchList;

  @override
  String toString() {
    return 'MovieDetailPageArgs{key: $key, movie: $movie, fromWatchList: $fromWatchList}';
  }
}

/// generated route for
/// [_i7.TvShowDetailPage]
class TvShowDetailPage extends _i8.PageRouteInfo<TvShowDetailPageArgs> {
  TvShowDetailPage({
    _i9.Key? key,
    required _i11.TvShow tvShow,
    bool fromWatchList = false,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          TvShowDetailPage.name,
          args: TvShowDetailPageArgs(
            key: key,
            tvShow: tvShow,
            fromWatchList: fromWatchList,
          ),
          initialChildren: children,
        );

  static const String name = 'TvShowDetailPage';

  static const _i8.PageInfo<TvShowDetailPageArgs> page =
      _i8.PageInfo<TvShowDetailPageArgs>(name);
}

class TvShowDetailPageArgs {
  const TvShowDetailPageArgs({
    this.key,
    required this.tvShow,
    this.fromWatchList = false,
  });

  final _i9.Key? key;

  final _i11.TvShow tvShow;

  final bool fromWatchList;

  @override
  String toString() {
    return 'TvShowDetailPageArgs{key: $key, tvShow: $tvShow, fromWatchList: $fromWatchList}';
  }
}
