import 'package:flutter/material.dart';

class ColorsFrave {

  static const Color primary = Color(0xff00257A);
  static const Color background = Color(0xffFFFFFF);
  static const Color backgroundTextField = Color(0xffF5F5F5);
  static const Color grey = Color(0xff8D949F);
  static const Color backgrondGrey = Color(0xffF7F8F9);
  static const Color redLogOut = Color(0xffBC4841);
  static const Color subtitle = Color(0xff7e8896);

}

class ThemesFraved {

  static ThemeData appTheme = ThemeData(

    brightness: Brightness.light,
    scaffoldBackgroundColor: ColorsFrave.background,
    primaryColor: Colors.black87,
    colorScheme: const ColorScheme.light(),
    cardColor: Colors.white,
    cardTheme: const CardTheme(color: Color(0xffF8F9FA)),
    iconTheme: const IconThemeData(color: Colors.black),
    primaryColorDark: Colors.black,
    dialogBackgroundColor: ColorsFrave.background,

    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: ColorsFrave.background,
      iconTheme: IconThemeData(color: Colors.black),
    )

  );


  static ThemeData appThemeDark = ThemeData(
    
    primaryColorDark: Colors.white60,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF202630),
    colorScheme: const ColorScheme.dark(),
    cardTheme: const CardTheme(color: Color(0xff29313D)),
    iconTheme: const IconThemeData(color: Colors.white),
    primaryColor: Colors.white,
    cardColor: const Color(0xff29313D),
    dialogBackgroundColor: const Color(0xFF202630),
    

    appBarTheme:  const AppBarTheme(
      elevation: 0,
      backgroundColor: Color(0xFF202630),
      iconTheme: IconThemeData(color: Color(0xffEEEEEE)),
      toolbarTextStyle: TextStyle(color: Color(0xffEEEEEE)),
    ),
  );

}