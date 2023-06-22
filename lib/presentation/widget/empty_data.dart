import 'package:e_movie/config/util/app_theme.dart';
import 'package:e_movie/presentation/widget/spacing.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyDataView extends StatelessWidget {
  const EmptyDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        verticalSpacing(48),
        Lottie.asset(
          'assets/anim/anim_empty.json',
          width: double.infinity,
        ),
        Text(
          'No Data Found!',
          style: AppTheme.subtitle3(color: AppTheme.white),
        )
      ],
    );
  }
}
