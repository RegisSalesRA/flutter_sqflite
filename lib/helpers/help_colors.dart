import 'package:flutter/material.dart';

abstract class Palette {
  static const MaterialColor kToDark = MaterialColor(
    0xff00254d, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffce5641), //10%
      100: Color(0xffb74c3a), //20%
      200: Color(0xffa04332), //30%
      300: Color(0xff89392b), //40%
      400: Color(0xff733024), //50%
      500: Color(0xff5c261d), //60%
      600: Color(0xff451c16), //70%
      700: Color(0xff2e130e), //80%
      800: Color(0xff170907), //90%
      900: Color(0xff000000), //100%
    },
  );

  static const Color primaryColor = Color.fromRGBO(0, 37, 77, 1);
  static const Color primaryColorLight = Color.fromRGBO(0, 73, 153, 1);
  static const Color primaryColorDark = Color(0xFF021338);
  static const Color textColor = (Color(0xFFFFFFFF));
  static const Color textCard = (Color.fromARGB(255, 0, 0, 0));
  static const Color primaryTest = Color.fromRGBO(168, 149, 50, 1);
}
