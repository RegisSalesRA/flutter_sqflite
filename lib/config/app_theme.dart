// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../ui/pages/pages.dart';
import 'config.dart';

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
            color: Palette.primaryColorDark,
          ),
          headline2: TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Palette.textColor,
          ),
          headline3: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Palette.textColor,
          ),
          headline4: TextStyle(
            //overflow: TextOverflow.ellipsis,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Palette.textCard,
          ),
        ),
        // Input Css
        inputDecorationTheme: InputDecorationTheme(
            suffixIconColor: Colors.grey.shade400,
            fillColor: Colors.white,
            filled: true,
            isDense: true,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.grey.shade200,
                  width: 2,
                )),
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(width: 2, color: Colors.grey.shade200)),
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
      ),
      home: const HomeScreen(),
    );
  }
}
