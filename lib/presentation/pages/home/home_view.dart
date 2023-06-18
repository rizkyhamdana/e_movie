import 'package:auto_route/auto_route.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:e_movie/config/services/injection.dart';
import 'package:e_movie/config/util/app_theme.dart';
import 'package:e_movie/config/util/custom_widget.dart';
import 'package:e_movie/config/util/preferences.dart';
import 'package:e_movie/config/util/utility.dart';
import 'package:e_movie/data/model/forecast.dart';
import 'package:e_movie/presentation/pages/home/home_cubit.dart';
import 'package:e_movie/presentation/pages/home/home_state.dart';
import 'package:e_movie/presentation/widget/spacing.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  ForecastResponse forecastResponse = ForecastResponse();
  bool isCurrentLocation = true;

  var cubit = getIt<HomeCubit>();
  double lat = 0;
  double lon = 0;

  Future getCurrentLocation() async {
    lat = await Prefs.getLat;
    lon = await Prefs.getLong;
  }

  String capitalize(String input) {
    List<String> words = input.split(' ');

    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] = '${words[i][0].toUpperCase()}${words[i].substring(1)}';
      }
    }

    return words.join(' ');
  }

  String roundedConvertToCelsius(double kelvin) {
    var temp = (kelvin - 273.15).roundToDouble();
    return '${temp.toStringAsFixed(0)}˚';
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    getCurrentLocation().then((value) => cubit.getForecast(lat, lon));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: bodyView(),
    );
  }

  Widget bodyView() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: 24,
          right: 24,
          bottom: MediaQuery.of(context).padding.bottom + 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Text(
              'Hello!',
              style: AppTheme.title(),
            ),
          ),
          verticalSpacing(4),
          Text(
            'Discover Forecast Weather',
            style: AppTheme.body1(),
          ),
          verticalSpacing(),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      hintText: 'Search city here...',
                      hintStyle:
                          AppTheme.hintSearch(color: AppTheme.blackColor2),
                      border: InputBorder.none,
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: AppTheme.blackColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _searchController.clear();
                                  isCurrentLocation = true;
                                });
                                cubit.getForecast(lat, lon);
                              },
                            )
                          : null,
                    ),
                    style: AppTheme.body3(),
                  ),
                ),
              ),
              horizontalSpacing(),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    if (_searchController.text != '') {
                      setState(() {
                        isCurrentLocation = false;
                      });
                      cubit.getCity(_searchController.text);
                    }
                  },
                ),
              ),
            ],
          ),
          verticalSpacing(32),
          Expanded(child: bloc()),
        ],
      ),
    );
  }

  Widget bloc() {
    return BlocConsumer<HomeCubit, HomeState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is HomeForecastLoaded) {
          forecastResponse = state.forecastResponse;
          return bodyViewLoaded();
        }
        if (state is HomeError) {
          return bodyViewError(state.error);
        }

        return bodyViewLoading();
      },
      listener: (context, state) {
        if (state is HomeEmpty) {
          isCurrentLocation = true;
          AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            animType: AnimType.rightSlide,
            title: 'City Not Found',
            desc: 'Check again your query...',
            btnOkOnPress: () {
              getCurrentLocation().then((value) => cubit.getForecast(lat, lon));
            },
          ).show();
        }
      },
    );
  }

  Widget bodyViewLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.black12,
      highlightColor: AppTheme.white,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 154.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            verticalSpacing(32),
            Container(
              width: 100,
              height: 18.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            verticalSpacing(24),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      horizontalSpacing(),
                      Column(
                        children: [
                          Container(
                            width: 100,
                            height: 14.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          verticalSpacing(4),
                          Container(
                            width: 100,
                            height: 14.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      horizontalSpacing(),
                      Column(
                        children: [
                          Container(
                            width: 100,
                            height: 14.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          verticalSpacing(4),
                          Container(
                            width: 100,
                            height: 14.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            verticalSpacing(24),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      horizontalSpacing(),
                      Column(
                        children: [
                          Container(
                            width: 100,
                            height: 14.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          verticalSpacing(4),
                          Container(
                            width: 100,
                            height: 14.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      horizontalSpacing(),
                      Column(
                        children: [
                          Container(
                            width: 100,
                            height: 14.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          verticalSpacing(4),
                          Container(
                            width: 100,
                            height: 14.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            verticalSpacing(48),
            Container(
              width: 100,
              height: 18.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            verticalSpacing(),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppTheme.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      offset: const Offset(0, 2),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                              ),
                              horizontalSpacing(),
                              Container(
                                width: 148,
                                height: 14.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 32,
                                height: 14.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              horizontalSpacing(),
                              Container(
                                width: 32,
                                height: 14.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      verticalSpacing(8),
                      Container(
                        width: double.infinity,
                        height: 0.1,
                        color: AppTheme.blackColor2,
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget bodyViewLoaded() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: AppTheme.gradient1(),
              image: DecorationImage(
                image: const AssetImage('assets/images/ic_bg.png'),
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter,
                colorFilter: ColorFilter.mode(
                  AppTheme.blackColor2.withOpacity(0.1),
                  BlendMode.dstIn,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Image.asset(
                        imagePaths(
                          Utility.getWeatherImages(
                              forecastResponse.list![0].weather![0].id!),
                        ),
                        alignment: Alignment.topCenter,
                        width: 80,
                        height: 80,
                      ),
                    ),
                    horizontalSpacing(16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            capitalize(forecastResponse
                                .list![0].weather![0].description!),
                            style: AppTheme.body3(color: AppTheme.white)),
                        Text(
                            roundedConvertToCelsius(
                                forecastResponse.list![0].main!.temp!),
                            style: AppTheme.custom(
                                size: 24,
                                weight: FontWeight.bold,
                                color: AppTheme.white)),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                          isCurrentLocation
                              ? 'Current Location'
                              : 'Searched Location',
                          style: AppTheme.body3(color: AppTheme.white)),
                      Text(
                        forecastResponse.city!.name!,
                        style: AppTheme.subtitle3(color: AppTheme.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          verticalSpacing(32),
          Text(
            'Today Details',
            style: AppTheme.subtitle2(),
          ),
          verticalSpacing(24),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: detailItem(
                  imagePaths('ic_temp'),
                  'Feel like',
                  roundedConvertToCelsius(
                      forecastResponse.list![0].main!.feelsLike!),
                ),
              ),
              Expanded(
                  child: detailItem(imagePaths('ic_humidity'), 'Humidity',
                      '${forecastResponse.list![0].main!.humidity}%')),
            ],
          ),
          verticalSpacing(24),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: detailItem(imagePaths('ic_wind'), 'Wind Speed',
                      '${forecastResponse.list![0].wind!.speed} m/s')),
              Expanded(
                  child: detailItem(imagePaths('ic_pressure'), 'Pressure',
                      '${forecastResponse.list![0].main!.pressure} hPa')),
            ],
          ),
          verticalSpacing(48),
          Text(
            'Next 5 Days',
            style: AppTheme.subtitle2(),
          ),
          verticalSpacing(),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: forecastResponse.list!.length ~/ 8,
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context, int index) {
              final dataIndex = (index + 1) * 8 -
                  1; // Menghitung indeks data dengan kelipatan 8
              final data = forecastResponse.list![dataIndex];
              return listForecast(data);
            },
          ),
        ],
      ),
    );
  }

  Widget detailItem(String iconPath, String itemTitle, String itemValue) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: Image.asset(
            iconPath,
            color: AppTheme.blackColor,
          ),
        ),
        horizontalSpacing(12),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                itemTitle,
                style: AppTheme.body3(),
              ),
              verticalSpacing(4),
              Text(
                itemValue,
                style: AppTheme.subtitle3(),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget listForecast(ListForecast list) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    imagePaths(
                      Utility.getWeatherImages(list.weather![0].id!),
                    ),
                    alignment: Alignment.topCenter,
                    width: 32,
                    height: 32,
                  ),
                  horizontalSpacing(),
                  Text(
                    DateFormat('EEE, dd-MMM-yy ')
                        .format(list.dtTxt!)
                        .toString(),
                    style: AppTheme.body3(),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    roundedConvertToCelsius(list.main!.tempMin!),
                    style: AppTheme.subtitle1(),
                  ),
                  horizontalSpacing(),
                  Text(
                    roundedConvertToCelsius(list.main!.tempMax!),
                    style: AppTheme.subtitle1(color: AppTheme.blackColor2),
                  ),
                ],
              ),
            ],
          ),
          verticalSpacing(8),
          Container(
            width: double.infinity,
            height: 0.1,
            color: AppTheme.blackColor2,
          )
        ],
      ),
    );
  }

  Widget bodyViewError(String error) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 120),
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: Lottie.asset(
                'assets/anim/anim_failed.json',
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Failed To Load',
                style: AppTheme.subtitle1(),
              ),
            ),
            verticalSpacing(8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Error: $error',
                textAlign: TextAlign.center,
                style: AppTheme.body2(),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
              child: ElevatedButton(
                onPressed: () {
                  getCurrentLocation()
                      .then((value) => cubit.getForecast(lat, lon));
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  backgroundColor: AppTheme.white,
                  foregroundColor: AppTheme.blue1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(
                          width: 0.1, color: AppTheme.blackColor2)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.refresh),
                    horizontalSpacing(8),
                    Text(
                      'Refresh',
                      style: AppTheme.subtitle3(color: AppTheme.blue1),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
