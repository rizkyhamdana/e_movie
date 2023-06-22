import 'package:auto_route/auto_route.dart';
import 'package:e_movie/data/model/tv_show.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TvShowDetailPage extends StatefulWidget {
  const TvShowDetailPage({super.key, required this.tvShow});
  final TvShow tvShow;

  @override
  State<TvShowDetailPage> createState() => _TvShowDetailPageState();
}

class _TvShowDetailPageState extends State<TvShowDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
