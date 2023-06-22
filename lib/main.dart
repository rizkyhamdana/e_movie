import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:e_movie/config/helper/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:e_movie/config/util/app_config.dart';

import 'config/route/app_route.dart';
import 'config/services/injection.dart';

void main() async {
  configureDependencies();
  // Initialize the dat
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.database;
  AppConfig.isDebug = true;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();
  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(
        navigatorObservers: () => [MyObserver()],
      ),
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

class MyObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    log('Route Pushed to: ${route.settings.name ?? 'Dialog'}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('Route Popped to: ${previousRoute?.settings.name}');
  }

  // only override to observer tab routes
}
