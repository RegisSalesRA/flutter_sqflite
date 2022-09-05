import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sqlite/ui/pages/home_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    final primaryColor = Color.fromRGBO(136, 14, 79, 1);
    final primaryColorDark = Color.fromRGBO(96, 0, 39, 1);
    final primaryColorLight = Color.fromRGBO(188, 71, 123, 1);

    return MaterialApp(
      title: '4Dev',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
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
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: primaryColorDark,
            ),
            headline2: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColorDark,
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
                  borderSide: BorderSide(color: primaryColor)),
              hintStyle: TextStyle(color: primaryColor, fontSize: 14),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  borderSide: BorderSide(color: primaryColor)),
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          )),
      home: HomePage(),
    );
  }
}
