import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color secondary = const Color(0xF0FFFFFF);
Color background = const Color(0xFF040C23);
Color gray = const Color(0xFF8789A3);
Color secondaryDark = const Color.fromARGB(255, 77, 117, 9);
Color primaryDark = const Color(0xFF629C59);
Color tertiary = const Color(0xFF9AC850);

final TextStyle kBodyText = GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: secondary);

ThemeData appDark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryDark,
    scaffoldBackgroundColor: secondaryDark,
    appBarTheme: AppBarTheme(
        backgroundColor: secondaryDark,
        titleTextStyle: TextStyle(
            color: secondary, fontWeight: FontWeight.w600, fontSize: 18),
        iconTheme: IconThemeData(color: secondary)),
    textTheme: TextTheme(
        bodyText1: TextStyle(color: secondary),
        bodyText2: TextStyle(color: secondary)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: secondaryDark,
    ),);

ThemeData appLight = ThemeData(
    brightness: Brightness.light,
    primaryColor: tertiary,
    scaffoldBackgroundColor: secondary,
    appBarTheme: AppBarTheme(
        backgroundColor: secondary,
        titleTextStyle: TextStyle(
            color: background, fontWeight: FontWeight.w600, fontSize: 18),
        iconTheme: IconThemeData(color: background)),
    textTheme: TextTheme(
        bodyText1: TextStyle(color: background),
        bodyText2: TextStyle(color: background)),
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: secondary));