import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_movie/config/util/custom_widget.dart';
import 'package:e_movie/data/model/movie.dart';
import 'package:e_movie/presentation/pages/movie/movie_state.dart';
import 'package:e_movie/presentation/widget/stroke_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:e_movie/config/services/injection.dart';
import 'package:e_movie/config/util/app_theme.dart';
import 'package:e_movie/config/util/constant.dart';
import 'package:e_movie/presentation/pages/movie/movie_cubit.dart';
import 'package:e_movie/presentation/widget/spacing.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MoviePage extends StatefulWidget {
  const MoviePage({super.key});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage>
    with SingleTickerProviderStateMixin {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;
  var cubit = getIt<MovieCubit>();

  List<Movie> topMovieList = [];
  bool isTopMovieLoading = true;
  bool isListMovieLoading = true;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    cubit.getTopListMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Movie',
                style: AppTheme.custom(
                    size: 24, color: AppTheme.white, weight: FontWeight.bold),
              ),
            ),
            verticalSpacing(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 16),
                      decoration: BoxDecoration(
                          color: AppTheme.blackColor2.withOpacity(0.5),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomLeft: Radius.circular(16))),
                      child: TextField(
                        focusNode: _focusNode,
                        controller: _searchController,
                        textInputAction: TextInputAction.search,
                        cursorColor: AppTheme.blue1,
                        onSubmitted: (value) {},
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          hintText: 'Search movie here...',
                          hintStyle: AppTheme.hintSearch(color: AppTheme.white),
                          border: InputBorder.none,
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.close,
                                    color: AppTheme.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _searchController.clear();
                                    });
                                  },
                                )
                              : null,
                        ),
                        style: AppTheme.body3(color: AppTheme.white),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppTheme.blackColor2.withOpacity(0.5),
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16)),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.search),
                      color: AppTheme.white,
                      onPressed: () {
                        _focusNode.unfocus();
                        cubit.getListMovie(Constant.MOVPOPULAR);
                        if (_searchController.text != '') {}
                      },
                    ),
                  ),
                ],
              ),
            ),
            verticalSpacing(32),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 80),
                child: Column(
                  children: [
                    BlocListener<MovieCubit, MovieState>(
                        listener: (context, state) {
                          if (state is MovieLoaded) {
                            cubit.getListMovie(Constant.MOVNOWPLAYING);
                            setState(() {
                              isTopMovieLoading = false;
                              topMovieList = state.movieResponse.results!;
                            });
                          } else if (state is MovieError) {
                            cubit.getListMovie(Constant.MOVNOWPLAYING);
                            debugPrint('ERRORNYA: ${state.error}');
                          } else if (state is MovieEmpty) {
                            cubit.getListMovie(Constant.MOVNOWPLAYING);
                          }
                        },
                        child: isTopMovieLoading
                            ? topMovieListLoading()
                            : topMovieLoaded(topMovieList)),
                    verticalSpacing(32),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: AppTheme.bgColor,
                        border: Border(
                          bottom: BorderSide(
                              color: Colors.transparent,
                              width: 0), // Remove the bottom border
                        ),
                      ),
                      child: TabBar(
                        isScrollable: true,
                        labelStyle: AppTheme.subtitle3(),
                        unselectedLabelStyle: AppTheme.body3(),
                        labelColor: AppTheme.white,
                        unselectedLabelColor: AppTheme.blackColor2,
                        dividerColor: Colors.transparent,
                        indicatorColor: AppTheme.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        controller: _tabController,
                        onTap: (value) {
                          switch (value) {
                            case 0:
                              cubit.getListMovie(Constant.MOVNOWPLAYING);
                              break;
                            case 1:
                              cubit.getListMovie(Constant.MOVUPCOMING);
                              break;
                            case 2:
                              cubit.getListMovie(Constant.MOVTOPRATED);
                              break;
                            case 3:
                              cubit.getListMovie(Constant.MOVPOPULAR);
                              break;
                            default:
                              break;
                          }
                        },
                        tabs: const [
                          Tab(text: 'Now Playing'),
                          Tab(text: 'Upcoming'),
                          Tab(text: 'Top Rated'),
                          Tab(text: 'Popular'),
                        ],
                      ),
                    ),
                    verticalSpacing(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: BlocBuilder<MovieCubit, MovieState>(
                        builder: (context, state) {
                          debugPrint('State Sekarang: $state');
                          if (state is ListMovieLoaded) {
                            return listMovieLoaded(state.movieResponse.results);
                          } else {
                            return listMovieLoading();
                          }
                        },
                      ),
                    ),
                    verticalSpacing(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget topMovieListLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.black12,
      highlightColor: AppTheme.white,
      child: SizedBox(
        height: 200,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          padding: const EdgeInsets.only(left: 16, right: 16),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: 160,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 140,
                      height: 180,
                      color: AppTheme.blue1,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget topMovieLoaded(List<Movie>? listMovie) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        padding: const EdgeInsets.only(left: 24, right: 24),
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 160,
            child: Stack(
              children: [
                Positioned(
                    top: 0,
                    right: 0,
                    child: SizedBox(
                      width: 160,
                      height: 180,
                      child: CachedNetworkImage(
                        imageUrl:
                            imageNetworkPaths(listMovie![index].posterPath!),
                        placeholder: (context, url) {
                          return Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: AppTheme.white,
                            child: Container(
                              width: 160,
                              height: 180,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              color: AppTheme.blue1,
                            ),
                          );
                        },
                      ),
                    )),
                Positioned(
                    left: 0,
                    bottom: 0,
                    child: StrokeText(
                        text: '${index + 1}',
                        strokeWidth: 2,
                        textColor: AppTheme.bgColor,
                        strokeColor: AppTheme.blue1,
                        fontSize: 80)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget listMovieLoaded(List<Movie>? listMovie) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: listMovie!.length,
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 0,
      ),
      itemBuilder: (BuildContext context, int index) {
        return CachedNetworkImage(
          imageUrl: imageNetworkPaths(listMovie[index].posterPath!),
          placeholder: (context, url) {
            return Shimmer.fromColors(
              baseColor: Colors.black12,
              highlightColor: AppTheme.white,
              child: Container(
                width: 160,
                height: 180,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                color: AppTheme.blue1,
              ),
            );
          },
        );
      },
    );
  }

  Widget listMovieLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.black12,
      highlightColor: AppTheme.white,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: 9,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            color: AppTheme.blue1,
          );
        },
      ),
    );
  }
}
