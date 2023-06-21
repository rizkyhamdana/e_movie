// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:e_movie/presentation/pages/home/details/home_details_view.dart'
    as _i2;
import 'package:e_movie/presentation/pages/home/home_view.dart' as _i1;
import 'package:e_movie/presentation/pages/movie/movie_view.dart' as _i3;
import 'package:e_movie/presentation/pages/onboarding/onboarding_view.dart'
    as _i6;
import 'package:e_movie/presentation/pages/splashscreen/splash_screen_view.dart'
    as _i5;
import 'package:e_movie/presentation/pages/tv_show/tv_show_view.dart' as _i4;
import 'package:e_movie/presentation/pages/watchlist/watchlist_view.dart'
    as _i7;

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
    HomeDetailsPage.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeDetailsPage(),
      );
    },
    MoviePage.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.MoviePage(),
      );
    },
    TvShowPage.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.TvShowPage(),
      );
    },
    SplashRoutePage.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.SplashScreenPage(),
      );
    },
    OnboardingPage.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.OnboardingPage(),
      );
    },
    WatchlistPage.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.WatchlistPage(),
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
/// [_i2.HomeDetailsPage]
class HomeDetailsPage extends _i8.PageRouteInfo<void> {
  const HomeDetailsPage({List<_i8.PageRouteInfo>? children})
      : super(
          HomeDetailsPage.name,
          initialChildren: children,
        );

  static const String name = 'HomeDetailsPage';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i3.MoviePage]
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
/// [_i4.TvShowPage]
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
/// [_i5.SplashScreenPage]
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
/// [_i6.OnboardingPage]
class OnboardingPage extends _i8.PageRouteInfo<void> {
  const OnboardingPage({List<_i8.PageRouteInfo>? children})
      : super(
          OnboardingPage.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingPage';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i7.WatchlistPage]
class WatchlistPage extends _i8.PageRouteInfo<void> {
  const WatchlistPage({List<_i8.PageRouteInfo>? children})
      : super(
          WatchlistPage.name,
          initialChildren: children,
        );

  static const String name = 'WatchlistPage';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}
