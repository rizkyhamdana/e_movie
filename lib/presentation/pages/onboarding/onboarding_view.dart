import 'package:auto_route/auto_route.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:e_movie/config/route/app_route.gr.dart';
import 'package:e_movie/config/services/injection.dart';
import 'package:e_movie/config/util/app_theme.dart';
import 'package:lottie/lottie.dart';
import 'package:e_movie/config/util/preferences.dart';
import 'package:e_movie/config/util/utility.dart';
import 'package:e_movie/presentation/pages/onboarding/onboarding_cubit.dart';
import 'package:e_movie/presentation/pages/onboarding/onboarding_state.dart';
import 'package:e_movie/presentation/widget/spacing.dart';

@RoutePage()
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  var cubit = getIt<OnboardingCubit>();
  @override
  void initState() {
    super.initState();

    Utility.getUserLocation();
  }

  Widget bloc() {
    return BlocConsumer<OnboardingCubit, OnboardingState>(
      bloc: cubit,
      builder: (context, state) {
        return bodyView();
      },
      listener: (context, state) {
        if (state is LocationFailed) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            animType: AnimType.rightSlide,
            title: 'Permission Problem!',
            desc: 'Please Give Location Permission to This App...',
            btnOkOnPress: () {
              openAppSettings();
            },
          ).show();
        }
        if (state is LocationGet) {
          Prefs.setFirstLaunch(false);
          context.router.replace(const HomePage());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bloc(),
    );
  }

  Widget bodyView() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          bottom: MediaQuery.of(context).padding.bottom + 24),
      decoration: BoxDecoration(
        gradient: AppTheme.gradient1(),
      ),
      child: Column(
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48.0),
                child: Lottie.asset('assets/anim/anim_oob.json',
                    width: double.infinity),
              ),
              verticalSpacing(32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Simple Weather Forecast',
                  textAlign: TextAlign.center,
                  style: AppTheme.custom(
                      size: 22, color: AppTheme.white, weight: FontWeight.w600),
                ),
              ),
              verticalSpacing(32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Get real-time weather forecasts for your location and more.',
                  textAlign: TextAlign.center,
                  style: AppTheme.body2(color: AppTheme.white),
                ),
              )
            ],
          )),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                cubit.getLocation();
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                backgroundColor: AppTheme.white,
                foregroundColor: AppTheme.blue1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(
                'Get Started',
                style: AppTheme.subtitle2(color: AppTheme.blue1),
              ),
            ),
          )
        ],
      ),
    );
  }
}
