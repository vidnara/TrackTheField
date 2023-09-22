import 'package:flutter/material.dart';

MaterialColor PrimaryMaterialColor = MaterialColor(
  4278650650,
  <int, Color>{
    50: Color.fromRGBO(
      7,
      7,
      26,
      .1,
    ),
    100: Color.fromRGBO(
      7,
      7,
      26,
      .2,
    ),
    200: Color.fromRGBO(
      7,
      7,
      26,
      .3,
    ),
    300: Color.fromRGBO(
      7,
      7,
      26,
      .4,
    ),
    400: Color.fromRGBO(
      7,
      7,
      26,
      .5,
    ),
    500: Color.fromRGBO(
      7,
      7,
      26,
      .6,
    ),
    600: Color.fromRGBO(
      7,
      7,
      26,
      .7,
    ),
    700: Color.fromRGBO(
      7,
      7,
      26,
      .8,
    ),
    800: Color.fromRGBO(
      7,
      7,
      26,
      .9,
    ),
    900: Color.fromRGBO(
      7,
      7,
      26,
      1,
    ),
  },
);

ThemeData myTheme = ThemeData(
  fontFamily: "customFont",
  primaryColor: Color(0xff07071a),
  primarySwatch: PrimaryMaterialColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        Color(0xff07071a),
      ),
    ),
  ),
);
