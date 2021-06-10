import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

ThemeData lightTheme = ThemeData(
    // scrollbarTheme: ScrollbarThemeData(
    //     trackBorderColor: MaterialStateProperty.all(Colors.red),
    //     trackColor: MaterialStateProperty.all(Colors.black)),

    textTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        bodyText2: TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
      subtitle2: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 14.0,
        height: 1.3,
      ),
    ),
    fontFamily: 'jannah',
    indicatorColor: defaultColor,
    primarySwatch: defaultColor,
    scaffoldBackgroundColor: Colors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.black,
        selectedItemColor: defaultColor,
        type: BottomNavigationBarType.fixed,
        elevation: 20.0),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.black),
// actionsIconTheme: IconThemeData(
//   color: Colors.black,
// ),
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      titleTextStyle: TextStyle(
          fontFamily: 'jannah',
          color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
    ));
ThemeData darkTheme = ThemeData(
    textTheme: TextTheme(
      bodyText1: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      bodyText2: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
      ),
      subtitle2: TextStyle(
        color: Colors.white,
        fontSize: 14.0,
        height: 1.3,
      ),
    ),
    indicatorColor: Colors.deepOrange,
    primarySwatch: Colors.deepOrange,
    scaffoldBackgroundColor: Colors.grey,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.deepOrange,
        type: BottomNavigationBarType.fixed,
        elevation: 20.0),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
      // actionsIconTheme: IconThemeData(
      //   color: Colors.white,
      // ),
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.orangeAccent,
        statusBarIconBrightness: Brightness.dark,
      ),
      backgroundColor: Colors.grey,
      elevation: 0.0,
      centerTitle: true,
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
    ));
