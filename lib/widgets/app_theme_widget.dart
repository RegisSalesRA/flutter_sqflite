import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sqlite/ui/pages/home_screen.dart';

class Palette {
  static const MaterialColor kToDark = const MaterialColor(
    0xff00254d, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xffce5641), //10%
      100: const Color(0xffb74c3a), //20%
      200: const Color(0xffa04332), //30%
      300: const Color(0xff89392b), //40%
      400: const Color(0xff733024), //50%
      500: const Color(0xff5c261d), //60%
      600: const Color(0xff451c16), //70%
      700: const Color(0xff2e130e), //80%
      800: const Color(0xff170907), //90%
      900: const Color(0xff000000), //100%
    },
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    const Color primaryColor = Color.fromRGBO(0, 37, 77, 1);
    const Color primaryColorLight = Color.fromRGBO(0, 73, 153, 1);
    const Color primaryColorDark = Color(0xFF000000);
    const Color textColor = (Color(0xFFFFFFFF));

    return MaterialApp(
      title: 'Sqflite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Palette.kToDark,
          //Progress Indicator Css
          progressIndicatorTheme:
              ProgressIndicatorThemeData(color: primaryColorDark),
          // PrimariColors from App css
          primaryColor: primaryColor,
          primaryColorDark: primaryColorDark,
          primaryColorLight: primaryColorLight,
          accentColor: primaryColor,
          backgroundColor: Colors.white,
          // Text Css
          textTheme: TextTheme(
            subtitle1: TextStyle(color: primaryColorDark),
            headline1: TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
            headline2: TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          // Input Css
          inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(color: primaryColorDark),
              prefixIconColor: primaryColorDark,
              fillColor: Colors.grey.shade300,
              filled: true,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60),
                  borderSide: BorderSide(
                      color: primaryColor, width: 0, style: BorderStyle.none)),
              hintStyle: TextStyle(color: primaryColor, fontSize: 14),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  )),
              alignLabelWithHint: true),
          // Button css
          buttonTheme: ButtonThemeData(
            colorScheme: ColorScheme.light(primary: primaryColor),
            buttonColor: primaryColor,
            splashColor: primaryColorLight,
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          )),
      home: HomePage(),
    );
  }
}
