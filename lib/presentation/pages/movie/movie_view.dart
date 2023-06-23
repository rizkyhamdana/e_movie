import 'package:auto_route/auto_route.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_movie/config/route/app_route.gr.dart';
import 'package:e_movie/config/util/custom_widget.dart';
import 'package:e_movie/data/model/movie.dart';
import 'package:e_movie/presentation/pages/movie/movie_state.dart';
import 'package:e_movie/presentation/widget/empty_data.dart';
import 'package:e_movie/presentation/widget/list_loading.dart';
import 'package:e_movie/presentation/widget/movie_list.dart';
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
  bool isSearch = false;
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
                        onSubmitted: (value) {
                          if (value != "") {
                            setState(() {
                              isSearch = true;
                              cubit.searchMovie(value);
                            });
                          }
                        },
                        onChanged: (value) {
                          setState(() {});
                          if (isSearch && value == "") {
                            setState(() {
                              isSearch = false;
                              _searchController.clear();
                              cubit.getTopListMovie();
                            });
                          }
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
                                      isSearch = false;
                                      _searchController.clear();
                                      cubit.getTopListMovie();
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

                        if (_searchController.text != '') {
                          setState(() {
                            isSearch = true;
                            cubit.searchMovie(_searchController.text);
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            verticalSpacing(32),
            Expanded(
              child: isSearch ? bodySearchView() : bodyView(),
            )
          ],
        ),
      ),
    );
  }

  Widget bodyView() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
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
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.rightSlide,
                    title: 'Error',
                    desc: state.error,
                  ).show();
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  return MovieList(
                    listMovie: state.movieResponse.results!,
                  );
                } else {
                  return const ListLoading();
                }
              },
            ),
          ),
          verticalSpacing(),
        ],
      ),
    );
  }

  Widget bodySearchView() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 80),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocBuilder<MovieCubit, MovieState>(
              builder: (context, state) {
                debugPrint('State Sekarang: $state');
                if (state is MovieSearchLoaded) {
                  return MovieList(listMovie: state.movieResponse.results!);
                } else if (state is MovieSearchEmpty) {
                  return const EmptyDataView();
                } else if (state is MovieSearchError) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.rightSlide,
                    title: 'Error',
                    desc: state.error,
                  ).show();
                  return const ListLoading();
                } else {
                  return const ListLoading();
                }
              },
            ),
          ),
          verticalSpacing(),
        ],
      ),
    );
  }

  Widget topMovieListLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.black12,
      highlightColor: AppTheme.white,
      child: SizedBox(
        height: (MediaQuery.of(context).size.width - 48) / 3 * 1.6,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          padding: const EdgeInsets.only(left: 16, right: 16),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: (MediaQuery.of(context).size.width - 48) / 3,
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
      height: (MediaQuery.of(context).size.width - 48) / 3 * 1.6,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        padding: const EdgeInsets.only(left: 24, right: 24),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              context.router.push(MovieDetailPage(movie: listMovie[index]));
            },
            child: SizedBox(
              width: (MediaQuery.of(context).size.width - 48) / 3,
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      right: 0,
                      child: SizedBox(
                        width: (MediaQuery.of(context).size.width - 48) / 3,
                        height:
                            (MediaQuery.of(context).size.width - 48) / 3 * 1.4,
                        child: CachedNetworkImage(
                          imageUrl:
                              imageNetworkPaths(listMovie![index].posterPath!),
                          errorWidget: (context, url, error) {
                            return Container(
                              height: 160,
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
                                width:
                                    (MediaQuery.of(context).size.width - 48) /
                                        3,
                                height: 180,
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
            ),
          );
        },
      ),
    );
  }
}
