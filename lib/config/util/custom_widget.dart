import 'package:e_movie/config/util/constant.dart';

String imagePaths(String path) {
  return "assets/images/$path.png";
}

String imageNetworkPaths(String path) {
  return "${Constant.imagePath}$path";
}
