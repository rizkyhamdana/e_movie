import 'package:auto_route/auto_route.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_movie/config/route/app_route.gr.dart';
import 'package:e_movie/config/services/injection.dart';
import 'package:e_movie/config/util/app_theme.dart';
import 'package:e_movie/config/util/custom_widget.dart';
import 'package:e_movie/data/model/movie.dart';
import 'package:e_movie/presentation/pages/movie/detail/movie_detail_cubit.dart';
import 'package:e_movie/presentation/pages/movie/detail/movie_detail_state.dart';

import 'package:e_movie/presentation/widget/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

@RoutePage()
class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage(
      {super.key, required this.movie, this.fromWatchList = false});
  final Movie movie;
  final bool fromWatchList;

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var cubit = getIt<MovieDetailCubit>();

  bool isWatchList = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
    cubit.getMovieById(widget.movie.id!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MovieDetailCubit, MovieDetailState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is MovieIsWatchList) {
          setState(() {
            isWatchList = true;
          });
        } else if (state is MovieIsNotWatchList) {
          setState(() {
            isWatchList = false;
          });
        } else if (state is MovieSaved) {
          AwesomeDialog(
            context: context,
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            dialogBackgroundColor: AppTheme.bgColor,
            titleTextStyle: AppTheme.subtitle2(color: AppTheme.white),
            descTextStyle: AppTheme.body3(color: AppTheme.white),
            btnOkColor: AppTheme.blue1,
            buttonsTextStyle: AppTheme.subtitle3(color: AppTheme.white),
            title: 'Success',
            desc: 'Movie add to watchlist!',
            btnOkText: 'Ok',
            btnOkOnPress: () {
              cubit.getMovieById(widget.movie.id!);
            },
          ).show();
        } else if (state is MovieDeleted) {
          AwesomeDialog(
            context: context,
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            dialogBackgroundColor: AppTheme.bgColor,
            titleTextStyle: AppTheme.subtitle2(color: AppTheme.white),
            descTextStyle: AppTheme.body3(color: AppTheme.white),
            btnOkColor: AppTheme.blue1,
            buttonsTextStyle: AppTheme.subtitle3(color: AppTheme.white),
            title: 'Success',
            desc: 'Movie remove from watchlist!',
            btnOkText: 'Ok',
            btnOkOnPress: () {
              cubit.getMovieById(widget.movie.id!);
              if (widget.fromWatchList == true) {
                context.router
                    .replace(const HomePage())
                    .then((value) => context.router.removeLast());
              }
            },
          ).show();
        } else if (state is MovieError) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'Error',
            desc: state.error,
          ).show();
        }
      },
      child: Scaffold(
        backgroundColor: AppTheme.bgColor,
        appBar: AppBar(
          backgroundColor: AppTheme.bgColor,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: SizedBox(
              width: 32,
              height: 32,
              child: IconButton(
                onPressed: () {
                  context.router.pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: AppTheme.white,
                ),
              ),
            ),
          ),
          title: Text(
            'Details Movie',
            style: AppTheme.subtitle1(color: AppTheme.white),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppTheme.blue1,
          onPressed: () {
            if (isWatchList) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.noHeader,
                animType: AnimType.rightSlide,
                dialogBackgroundColor: AppTheme.bgColor,
                titleTextStyle: AppTheme.subtitle2(color: AppTheme.white),
                descTextStyle: AppTheme.body3(color: AppTheme.white),
                btnOkColor: AppTheme.blue1,
                buttonsTextStyle: AppTheme.subtitle3(color: AppTheme.white),
                title: 'Are you sure?',
                desc: 'Remove this movie from your watchlist?',
                btnOkText: 'Yes',
                btnCancelText: 'No',
                btnOkOnPress: () {
                  cubit.deleteMovie(widget.movie.id!);
                },
                btnCancelOnPress: () {},
              ).show();
            } else {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.noHeader,
                animType: AnimType.rightSlide,
                dialogBackgroundColor: AppTheme.bgColor,
                titleTextStyle: AppTheme.subtitle2(color: AppTheme.white),
                descTextStyle: AppTheme.body3(color: AppTheme.white),
                btnOkColor: AppTheme.blue1,
                buttonsTextStyle: AppTheme.subtitle3(color: AppTheme.white),
                title: 'Are you sure?',
                desc: 'Add this movie to your watchlist?',
                btnOkText: 'Yes',
                btnCancelText: 'No',
                btnOkOnPress: () {
                  cubit.insertWatchListMovie(widget.movie);
                },
                btnCancelOnPress: () {},
              ).show();
            }
          },
          child: isWatchList
              ? const Icon(
                  Icons.bookmark_add,
                  color: AppTheme.white,
                )
              : const Icon(
                  Icons.bookmark_add_outlined,
                  color: AppTheme.white,
                ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: AppTheme.bgColor,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom + 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 0.77,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width * 0.56,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: imageNetworkPaths(
                              widget.movie.backdropPath ?? ''),
                          errorWidget: (context, url, error) {
                            return Container(
                              height: MediaQuery.of(context).size.width * 0.56,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          imagePaths('movie_placeholder')))),
                            );
                          },
                          placeholder: (context, url) {
                            return Shimmer.fromColors(
                              baseColor: Colors.black12,
                              highlightColor: AppTheme.white,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.width * 0.56,
                                color: AppTheme.blue1,
                              ),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 16,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width - 48) / 3,
                              height: (MediaQuery.of(context).size.width - 48) /
                                  3 *
                                  1.4,
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: imageNetworkPaths(
                                    widget.movie.posterPath ?? ''),
                                errorWidget: (context, url, error) {
                                  return Container(
                                    height: 160,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(imagePaths(
                                                'movie_placeholder')))),
                                  );
                                },
                                placeholder: (context, url) {
                                  return Shimmer.fromColors(
                                    baseColor: Colors.black12,
                                    highlightColor: AppTheme.white,
                                    child: Container(
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  48) /
                                              3,
                                      height: 180,
                                      color: AppTheme.blue1,
                                    ),
                                  );
                                },
                              ),
                            ),
                            horizontalSpacing(),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  verticalSpacing(
                                      (MediaQuery.of(context).size.width - 48) /
                                          4),
                                  Text(
                                    widget.movie.originalTitle ?? '-',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTheme.subtitle1(
                                        color: AppTheme.white),
                                  ),
                                  verticalSpacing(8),
                                  Text(
                                    DateFormat('dd MMMM yyyy').format(
                                      widget.movie.releaseDate != null
                                          ? DateFormat('yyyy-MM-dd')
                                              .parse(widget.movie.releaseDate!)
                                          : DateTime.now(),
                                    ),
                                    style: AppTheme.body3(
                                      color: AppTheme.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            horizontalSpacing(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                verticalSpacing(),
                TabBar(
                  isScrollable: true,
                  labelStyle: AppTheme.subtitle3(),
                  labelColor: AppTheme.white,
                  dividerColor: Colors.transparent,
                  indicatorColor: AppTheme.white,
                  padding: EdgeInsets.zero,
                  controller: _tabController,
                  tabs: const [
                    Tab(
                      text: 'Overview',
                    )
                  ],
                ),
                verticalSpacing(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    widget.movie.overview ?? '-',
                    style: AppTheme.body3(color: AppTheme.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
