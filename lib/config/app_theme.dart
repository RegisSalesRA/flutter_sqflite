// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../src/modules/home/home_screen.dart';
import 'config.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return MaterialApp(
      title: 'Flutter Sqflite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Palette.kToDark,
          // Progress Indicator Css
          progressIndicatorTheme: const ProgressIndicatorThemeData(
              color: Palette.primaryColorLight),
          // PrimariColors from App css
          primaryColor: Colors.white,
          primaryColorDark: Palette.primaryColorDark,
          primaryColorLight: Palette.primaryColorLight,
          accentColor: Palette.primaryColor,
          backgroundColor: Colors.white,
          // Text Css
          textTheme: const TextTheme(
            subtitle1: TextStyle(color: Palette.primaryColorLight),
            headline1: TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Palette.primaryColorLight,
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
                  borderSide:
                      BorderSide(width: 2, color: Colors.grey.shade200)),
              alignLabelWithHint: true),
          // Button css
          buttonTheme: ButtonThemeData(
            colorScheme:
                const ColorScheme.light(primary: Palette.primaryColorLight),
            buttonColor: Palette.primaryColorLight,
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
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Palette.primaryColorLight,
          )),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
      },
    );
  }
}
