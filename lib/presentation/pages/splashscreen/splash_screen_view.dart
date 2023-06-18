import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:e_movie/config/route/app_route.gr.dart';
import 'package:e_movie/config/util/app_theme.dart';
import 'package:e_movie/config/util/preferences.dart';

@RoutePage()
class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Prefs.getFistLaunch.then(
      (value) {
        if (value) {
          Timer(const Duration(seconds: 3), () {
            context.router.replace(const OnboardingPage());
          });
        } else {
          Timer(const Duration(seconds: 3), () {
            context.router.replace(const HomePage());
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return bodyView();
  }

  Widget bodyView() {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            bottom: MediaQuery.of(context).padding.bottom + 24),
        decoration: const BoxDecoration(color: AppTheme.white),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48.0),
                  child: Lottie.asset('assets/anim/anim_oob.json',
                      width: double.infinity),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'created by rizkyhamdana',
                textAlign: TextAlign.center,
                style: AppTheme.subtitle3(color: AppTheme.blackColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
