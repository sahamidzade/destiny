import 'package:dart_wormhole_gui/constants/asset_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors.dart';

class CustomTheme {
  static ThemeData get darkThemeMobile {
    return ThemeData(
        primaryColor: CustomColors.purple,
        primaryColorLight: CustomColors.lightPurple,
        scaffoldBackgroundColor: CustomColors.darkBlue,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: CustomColors.babyPowder),
        textTheme:  TextTheme(
          headline1: TextStyle(
              fontSize: 20.0.sp,
              color: CustomColors.babyPowder,
              fontFamily: MONTSERRAT,
              fontWeight: FontWeight.w500
          ),
          headline2: TextStyle(
              fontSize: 17.0.sp,
              color: CustomColors.babyPowder,
              fontFamily: ROBOTO,
              fontWeight: FontWeight.bold
          ),
          headline3: TextStyle(
              fontSize: 17.0.sp,
              color: CustomColors.babyPowder,
              fontFamily: LATO,
              fontWeight: FontWeight.w500
          ),
          headline4: TextStyle(
              fontSize: 17.0.sp,
              color: CustomColors.babyPowder,
              fontFamily: MONTSERRAT,
              fontWeight: FontWeight.w300
          ),
          headline5: TextStyle(
              fontSize: 12.0.sp,
              color: CustomColors.babyPowder,
              fontFamily: MONTSERRAT,
              fontWeight: FontWeight.w400
          ),
          bodyText1: TextStyle(
              color: CustomColors.babyPowder,
              fontSize: 14.sp,
              fontWeight: FontWeight.w300,
              fontFamily: MONTSERRAT,
          ),
          bodyText2: TextStyle(
              color: CustomColors.babyPowder,
              fontSize: 12.sp,
              fontWeight: FontWeight.w300,
              fontFamily: MONTSERRAT,
          ),
        ),
    );
  }

  static ThemeData get darkThemeDesktop {
    return ThemeData(
      primaryColor: CustomColors.purple,
      primaryColorDark: CustomColors.darkPurple,
      primaryColorLight: CustomColors.mediumPurple,
      scaffoldBackgroundColor: CustomColors.darkBlue,
      backgroundColor:  CustomColors.darkBlue,
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: CustomColors.babyPowder),
      textTheme: TextTheme(

      ),
    );
  }
}