// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../ui/pages/pages.dart';
import '../helpers/helpers.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mudar a cor dos itens na SafeArea
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return MaterialApp(
      title: 'Flutter Sqflite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Palette.kToDark,
          // Progress Indicator Css
          progressIndicatorTheme:
              const ProgressIndicatorThemeData(color: Palette.primaryColorDark),
          // PrimariColors from App css
          primaryColor: Palette.primaryColor,
          primaryColorDark: Palette.primaryColorDark,
          primaryColorLight: Palette.primaryColorLight,
          accentColor: Palette.primaryColor,
          backgroundColor: Colors.white,
          // Text Css
          textTheme: const TextTheme(
            subtitle1: TextStyle(color: Palette.primaryColorDark),
            headline1: TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Palette.textColor,
            ),
            headline2: TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Palette.textColor,
            ),
          ),
          // Input Css
          inputDecorationTheme: InputDecorationTheme(
              labelStyle: const TextStyle(color: Palette.primaryColorDark),
              prefixIconColor: Palette.primaryColorDark,
              fillColor: Colors.grey.shade300,
              filled: true,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60),
                  borderSide: const BorderSide(
                      color: Palette.primaryColor,
                      width: 0,
                      style: BorderStyle.none)),
              hintStyle:
                  const TextStyle(color: Palette.primaryColor, fontSize: 14),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  )),
              alignLabelWithHint: true),
          // Button css
          buttonTheme: ButtonThemeData(
            colorScheme: const ColorScheme.light(primary: Palette.primaryColor),
            buttonColor: Palette.primaryColor,
            splashColor: Palette.primaryColorLight,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          iconTheme: const IconThemeData(size: 25, color: Palette.primaryColor,)),
      home: const HomePage(),
    );
  }
}
