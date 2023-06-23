import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_movie/config/route/app_route.gr.dart';
import 'package:e_movie/config/util/app_theme.dart';
import 'package:e_movie/config/util/custom_widget.dart';
import 'package:e_movie/data/model/movie.dart';
import 'package:e_movie/presentation/widget/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MovieList extends StatelessWidget {
  const MovieList(
      {super.key, required this.listMovie, this.fromWatchList = false});
  final List<Movie> listMovie;
  final bool fromWatchList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: listMovie.length,
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: (MediaQuery.of(context).size.width - 32) / 3 * 1.8,
          crossAxisCount: 3,
          mainAxisSpacing: 24.0,
          crossAxisSpacing: 16,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              context.router.push(MovieDetailPage(
                movie: listMovie[index],
                fromWatchList: fromWatchList,
              ));
            },
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl:
                      imageNetworkPaths(listMovie[index].posterPath ?? ''),
                  fit: BoxFit.fitWidth,
                  errorWidget: (context, url, error) {
                    return Container(
                      height: 160,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage(imagePaths('movie_placeholder')))),
                    );
                  },
                  placeholder: (context, url) {
                    return Shimmer.fromColors(
                      baseColor: Colors.black12,
                      highlightColor: AppTheme.white,
                      child: Container(
                        height: 160,
                        color: AppTheme.blue1,
                      ),
                    );
                  },
                ),
                verticalSpacing(4),
                Text(
                  listMovie[index].title!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppTheme.body3(
                    color: AppTheme.white,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
