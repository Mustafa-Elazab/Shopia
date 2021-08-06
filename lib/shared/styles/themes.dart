import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app2/shared/styles/color.dart';

ThemeData lightTheme =ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primaryColor: default_color,
  appBarTheme: AppBarTheme(
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white, statusBarBrightness: Brightness.dark),
    color: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: default_color,
      elevation: 30.0
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
        color: Colors.black,
        fontSize: 18.0,
        fontWeight: FontWeight.w600
    ),
  ),
  primarySwatch: default_color,
);
ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: HexColor('333739'),
  primaryColor: default_color,
  appBarTheme: AppBarTheme(
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'), statusBarBrightness: Brightness.light),
    color:HexColor('333739'),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.white,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.redAccent,
      unselectedItemColor: Colors.grey,
      elevation: 30.0
      ,
      backgroundColor: HexColor('333739')
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: Colors.white,
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
    ),
  ),
  primarySwatch: Colors.red,
);