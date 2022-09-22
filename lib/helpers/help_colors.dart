import 'package:flutter/material.dart';

abstract class Palette {
  static const MaterialColor kToDark = MaterialColor(
    0xff00254d, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xFF004999), //10%
      100: Color(0xFF004999), //20%
      200: Color(0xFF00254d), //30%
      300: Color(0xFF00254d), //40%
      400: Color(0xFF00254d), //50%
      500: Color(0xFF021338), //60%
      600: Color(0xFF021338), //70%
      700: Color(0xFF021338), //80%
      800: Color(0xff170907), //90%
      900: Color(0xff000000), //100%
    },
  );

  static const Color primaryColor = Color(0xFF00254d);
  static const Color primaryColorLight = Color(0xFF004999);
  static const Color primaryColorDark = Color(0xFF021338);
  static const Color textColor = Color(0xFFFFFFFF);
  static const Color textCard = Color(0xFF021338);
  static Color greyShadeLight = Colors.grey.shade100;
}
