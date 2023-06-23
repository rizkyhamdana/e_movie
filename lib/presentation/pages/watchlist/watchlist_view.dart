import 'package:auto_route/auto_route.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:e_movie/config/services/injection.dart';
import 'package:e_movie/config/util/app_theme.dart';
import 'package:e_movie/data/model/movie.dart';
import 'package:e_movie/data/model/tv_show.dart';
import 'package:e_movie/presentation/pages/watchlist/watchlist_cubit.dart';
import 'package:e_movie/presentation/pages/watchlist/watchlist_state.dart';
import 'package:e_movie/presentation/widget/empty_data.dart';
import 'package:e_movie/presentation/widget/list_loading.dart';
import 'package:e_movie/presentation/widget/movie_list.dart';
import 'package:e_movie/presentation/widget/spacing.dart';
import 'package:e_movie/presentation/widget/tv_show_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool isShowMovie = true;
  var cubit = getIt<WatchListCubit>();

  List<Movie> listMovie = [];
  List<TvShow> listTvShow = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    cubit.getWatchListMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 80),
          child: Column(
            children: [
              Text(
                'Watch List',
                style: AppTheme.custom(
                    size: 24, color: AppTheme.white, weight: FontWeight.bold),
              ),
              verticalSpacing(),
              TabBar(
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
                      setState(() {
                        isShowMovie = true;
                      });
                      cubit.getWatchListMovie();

                      break;
                    case 1:
                      setState(() {
                        isShowMovie = false;
                      });
                      cubit.getWatchListTvShow();

                      break;
                    default:
                      break;
                  }
                },
                tabs: const [
                  Tab(text: 'Movie'),
                  Tab(text: 'Tv Show'),
                ],
              ),
              verticalSpacing(),
              isShowMovie
                  ? BlocConsumer<WatchListCubit, WatchListState>(
                      builder: (context, state) {
                        if (state is WatchListMovieLoaded) {
                          return MovieList(
                            listMovie: state.listMovie,
                            fromWatchList: true,
                          );
                        } else if (state is WatchListMovieEmpty) {
                          return const EmptyDataView();
                        }
                        return const ListLoading();
                      },
                      listener: (context, state) {
                        if (state is WatchListMovieError) {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: state.error,
                          ).show();
                        }
                      },
                    )
                  : BlocConsumer<WatchListCubit, WatchListState>(
                      builder: (context, state) {
                        if (state is WatchListTvShowLoaded) {
                          return TvShowList(
                            listTvShow: state.listTvShow,
                            fromWatchList: true,
                          );
                        } else if (state is WatchListTvShowEmpty) {
                          return const EmptyDataView();
                        }
                        return const ListLoading();
                      },
                      listener: (context, state) {
                        if (state is WatchListTvShowError) {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: state.error,
                          ).show();
                        }
                      },
                    )
            ],
          ),
        ),
      ),
    );
  }
}
