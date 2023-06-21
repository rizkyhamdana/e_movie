import 'package:auto_route/auto_route.dart';
import 'package:e_movie/data/model/movie.dart';
import 'package:e_movie/presentation/pages/movie/movie_state.dart';
import 'package:e_movie/presentation/widget/stroke_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
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

class _MoviePageState extends State<MoviePage> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  var cubit = getIt<MovieCubit>();

  List<Movie> topMovieList = [];

  @override
  void initState() {
    super.initState();
    cubit.getListMovie(Constant.MOVNOWPLAYING);
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
          children: [
            Text(
              'Movie',
              style: AppTheme.custom(
                  size: 24, color: AppTheme.white, weight: FontWeight.bold),
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
                    BlocBuilder<MovieCubit, MovieState>(
                      builder: (context, state) {
                        debugPrint('State Sekarang: $state');
                        if (state is MovieLoaded) {
                          return SizedBox(
                            height: 160,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  width: 128,
                                  margin:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top: 0,
                                          right: 0,
                                          child: Container(
                                            width: 120,
                                            height: 150,
                                            color: AppTheme.blue2,
                                          )),
                                      Positioned(
                                          left: 0,
                                          bottom: 0,
                                          child: StrokeText(
                                              text: '${index + 1}',
                                              strokeWidth: 1,
                                              textColor: AppTheme.bgColor,
                                              strokeColor: AppTheme.blue1,
                                              fontSize: 80)),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return bodyViewLoading();
                        }
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget bodyViewLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.black12,
      highlightColor: AppTheme.white,
      child: SizedBox(
        height: 160,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          padding: const EdgeInsets.only(left: 16, right: 16),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: 128,
              height: 160,
              margin: const EdgeInsets.only(left: 8, right: 8),
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 120,
                        height: 150,
                        color: AppTheme.blue2,
                      )),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
