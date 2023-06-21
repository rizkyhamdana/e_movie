import 'package:auto_route/auto_route.dart';
import 'package:e_movie/config/util/app_theme.dart';
import 'package:flutter/material.dart';

@RoutePage()
class WatchlistPage extends StatelessWidget {
  const WatchlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Text(
              'Watch List',
              style: AppTheme.custom(
                  size: 24, color: AppTheme.white, weight: FontWeight.bold),
            ),
            Container(
              padding: const EdgeInsets.only(top: 16),
            ),
          ],
        ),
      ),
    );
  }
}
