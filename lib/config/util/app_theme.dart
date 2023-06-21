import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const blackShadow = Color.fromRGBO(225, 224, 225, 1.0);
  static const Color blackColor = Color(0xFF383838);
  static const Color bgColor = Color(0xFF1F282B);
  static const Color bgColor2 = Color(0xFF121518);
  static const Color blackColor2 = Color(0xFF67686D);
  static const Color blue1 = Color(0xFF0296E5);
  static const Color blue2 = Color(0xFF689FFF);
  static const Color white = Color(0xFFFFFFFF);

  static Gradient gradient1({
    Alignment begin = Alignment.topLeft,
    Alignment end = Alignment.bottomRight,
    Color startColor = blue1,
    Color endColor = blue2,
  }) =>
      LinearGradient(
        begin: begin,
        end: end,
        colors: [startColor, endColor],
      );

  static List<BoxShadow> boxShadow = [
    const BoxShadow(
      color: AppTheme.blackShadow,
      offset: Offset(0, -2),
      spreadRadius: 0.1,
      blurRadius: 3,
    )
  ];

  static List<BoxShadow> boxShadow2 = [
    const BoxShadow(
      color: AppTheme.blackShadow,
      offset: Offset(0, 4),
      spreadRadius: 0,
      blurRadius: 12,
    )
  ];

  static const String fontName = 'Montserrat';

  static TextStyle title({
    Color? color = blackColor,
    TextDecoration? decoration,
    FontStyle? fontStyle,
  }) =>
      TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w600,
        fontSize: 28,
        color: color,
        decoration: decoration,
        fontStyle: fontStyle,
      );

  static TextStyle subtitle1({
    Color? color = blackColor,
    double? height,
    TextDecoration? decoration,
    FontStyle? fontStyle,
  }) =>
      TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w600,
        fontSize: 18,
        color: color,
        height: height,
        decoration: decoration,
        fontStyle: fontStyle,
      );

  static TextStyle subtitle2({
    Color? color = blackColor,
    TextDecoration? decoration,
    FontStyle? fontStyle,
  }) =>
      TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: color,
        decoration: decoration,
        fontStyle: fontStyle,
      );

  static TextStyle subtitle3({
    Color? color = blackColor,
    TextDecoration? decoration,
    FontStyle? fontStyle,
  }) =>
      TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: color,
        decoration: decoration,
        fontStyle: fontStyle,
      );

  static TextStyle body1({
    Color? color = blackColor,
    TextDecoration? decoration,
    FontStyle? fontStyle,
  }) =>
      TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w500,
        fontSize: 20,
        color: color,
        decoration: decoration,
        fontStyle: fontStyle,
      );

  static TextStyle body2({
    Color? color = blackColor,
    TextDecoration? decoration,
    FontStyle? fontStyle,
  }) =>
      TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: color,
        decoration: decoration,
        fontStyle: fontStyle,
      );

  static TextStyle body3({
    Color? color = blackColor,
    TextDecoration? decoration,
    FontStyle? fontStyle,
  }) =>
      TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: color,
        decoration: decoration,
        fontStyle: fontStyle,
      );

  static TextStyle hintSearch({
    Color? color = blackColor,
    TextDecoration? decoration,
    FontStyle? fontStyle,
  }) =>
      TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w400,
        fontSize: 12,
        color: color,
        decoration: decoration,
        fontStyle: fontStyle,
      );

  static TextStyle custom(
          {String? fontName = fontName,
          FontWeight? weight = FontWeight.w500,
          double? size = 16,
          double? letterSpacing,
          Color? color,
          TextDecoration? decoration,
          FontStyle? fontstyle}) =>
      TextStyle(
        fontStyle: fontstyle,
        fontFamily: fontName,
        fontWeight: weight,
        fontSize: size,
        letterSpacing: letterSpacing,
        color: color,
        decoration: decoration,
      );
}
