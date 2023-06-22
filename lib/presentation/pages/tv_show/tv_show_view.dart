import 'package:auto_route/auto_route.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_movie/config/services/injection.dart';
import 'package:e_movie/config/util/app_theme.dart';
import 'package:e_movie/config/util/constant.dart';
import 'package:e_movie/config/util/custom_widget.dart';
import 'package:e_movie/data/model/tv_show.dart';
import 'package:e_movie/presentation/pages/tv_show/tv_show_cubit.dart';
import 'package:e_movie/presentation/pages/tv_show/tv_show_state.dart';
import 'package:e_movie/presentation/widget/empty_data.dart';
import 'package:e_movie/presentation/widget/spacing.dart';
import 'package:e_movie/presentation/widget/stroke_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

@RoutePage()
class TvShowPage extends StatefulWidget {
  const TvShowPage({super.key});

  @override
  State<TvShowPage> createState() => _TvShowPageState();
}

class _TvShowPageState extends State<TvShowPage>
    with SingleTickerProviderStateMixin {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;
  var cubit = getIt<TvShowCubit>();

  List<TvShow> topTvShowist = [];
  bool isTopTvLoading = true;
  bool isSearch = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    cubit.getTopListTvShow();
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
                'TV Show',
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
                          setState(() {
                            isSearch = true;
                            cubit.searchTvShow(value);
                          });
                        },
                        onChanged: (value) {
                          setState(() {});
                          if (isSearch && value == "") {
                            setState(() {
                              isSearch = false;

                              cubit.getTopListTvShow();
                            });
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Search tv show here...',
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
                                      cubit.getTopListTvShow();
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
                        if (_searchController.text != '') {}
                        setState(() {
                          isSearch = true;
                          cubit.searchTvShow(_searchController.text);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            verticalSpacing(32),
            Expanded(child: isSearch ? bodySearchView() : bodyView()),
          ],
        ),
      ),
    );
  }

  Widget bodyView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 80),
      child: Column(
        children: [
          BlocListener<TvShowCubit, TvShowState>(
              listener: (context, state) {
                if (state is TvShowLoaded) {
                  cubit.getListTvShow(Constant.TVAIRING);
                  setState(() {
                    isTopTvLoading = false;
                    topTvShowist = state.tvShowResponse.results!;
                  });
                } else if (state is TvShowError) {
                  cubit.getListTvShow(Constant.TVAIRING);
                  debugPrint('ERRORNYA: ${state.error}');
                } else if (state is TvShowEmpty) {
                  cubit.getListTvShow(Constant.TVAIRING);
                }
              },
              child: isTopTvLoading
                  ? topTvShowListLoading()
                  : topTvShowLoaded(topTvShowist)),
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
                    cubit.getListTvShow(Constant.TVAIRING);
                    break;
                  case 1:
                    cubit.getListTvShow(Constant.TVONTHEAIR);
                    break;
                  case 2:
                    cubit.getListTvShow(Constant.TVTOPRATED);
                    break;
                  case 3:
                    cubit.getListTvShow(Constant.TVPOPULAR);
                    break;
                  default:
                    break;
                }
              },
              tabs: const [
                Tab(text: 'Airing Today'),
                Tab(text: 'On The Air'),
                Tab(text: 'Top Rated'),
                Tab(text: 'Popular'),
              ],
            ),
          ),
          verticalSpacing(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocBuilder<TvShowCubit, TvShowState>(
              builder: (context, state) {
                debugPrint('State Sekarang: $state');
                if (state is ListTvShowLoaded) {
                  return listTvShowLoaded(state.tvShowResponse.results);
                } else {
                  return listTvShowLoading();
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
      padding: const EdgeInsets.only(bottom: 80),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocBuilder<TvShowCubit, TvShowState>(
              builder: (context, state) {
                debugPrint('State Sekarang: $state');
                if (state is TvShowSearchLoaded) {
                  return listTvShowLoaded(state.tvShowResponse.results);
                } else if (state is TvShowSearchEmpty) {
                  return const EmptyDataView();
                } else if (state is TvShowSearchError) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.rightSlide,
                    title: 'Error',
                    desc: state.error,
                  ).show();
                  return listTvShowLoading();
                } else {
                  return listTvShowLoading();
                }
              },
            ),
          ),
          verticalSpacing(),
        ],
      ),
    );
  }

  Widget topTvShowListLoading() {
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

  Widget topTvShowLoaded(List<TvShow>? listTvShow) {
    return SizedBox(
      height: (MediaQuery.of(context).size.width - 48) / 3 * 1.6,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        padding: const EdgeInsets.only(left: 24, right: 24),
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
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
                            imageNetworkPaths(listTvShow![index].posterPath!),
                        placeholder: (context, url) {
                          return Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: AppTheme.white,
                            child: Container(
                              width:
                                  (MediaQuery.of(context).size.width - 48) / 3,
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
          );
        },
      ),
    );
  }

  Widget listTvShowLoaded(List<TvShow>? listTvShow) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: listTvShow!.length,
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: (MediaQuery.of(context).size.width - 32) / 3 * 1.6,
          crossAxisCount: 3,
          mainAxisSpacing: 24.0,
          crossAxisSpacing: 16,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              CachedNetworkImage(
                imageUrl: imageNetworkPaths(listTvShow[index].posterPath ?? ''),
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
                      width: 160,
                      color: AppTheme.blue1,
                    ),
                  );
                },
              ),
              verticalSpacing(4),
              Text(
                listTvShow[index].name!,
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
    );
  }

  Widget listTvShowLoading() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
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
            mainAxisExtent: (MediaQuery.of(context).size.width - 32) / 3 * 1.6,
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
