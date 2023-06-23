import 'package:e_movie/config/util/app_theme.dart';
import 'package:e_movie/presentation/widget/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListLoading extends StatelessWidget {
  const ListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Shimmer.fromColors(
        baseColor: Colors.black12,
        highlightColor: AppTheme.white,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: 9,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 24,
            mainAxisExtent: (MediaQuery.of(context).size.width - 32) / 3 * 1.8,
            crossAxisSpacing: 16,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Container(
                  height: 160,
                  color: AppTheme.blue1,
                ),
                verticalSpacing(4),
                Text(
                  'This is Shimmer Text',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppTheme.body3(
                    color: AppTheme.white,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
