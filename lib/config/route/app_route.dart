import 'package:auto_route/auto_route.dart';

import 'app_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoutePage.page,
          initial: true,
        ),
        AutoRoute(page: HomePage.page),
        AutoRoute(page: MoviePage.page),
        AutoRoute(page: TvShowPage.page),
        AutoRoute(page: TvShowDetailPage.page),
        AutoRoute(
          page: MovieDetailPage.page,
        ),
      ];
}
