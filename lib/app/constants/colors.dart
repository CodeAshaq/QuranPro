import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

Color secondary = const Color(0xF0FFFFFF);
Color background = const Color(0xFF040C23);
Color gray = const Color(0xFF8789A3);
Color secondaryDark = const Color.fromARGB(255, 77, 117, 9);
Color primaryDark = const Color(0xFF629C59);
Color tertiary = const Color(0xFF9AC850);
Color bluesky = const Color.fromARGB(255, 0, 26, 139);

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
  ),
);

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

String showGreeting() {
  var hour = DateTime.now().hour;
  if (hour >= 6 && hour < 12) {
    return 'Selamat Beraktivitas!';
  } else if (hour >= 12 && hour < 15) {
    return 'Jangan Lupa \nsolat Dzuhur!';
  } else if (hour >= 15 && hour < 18) {
    return 'Jangan lupa \nsolat Ashar!';
  } else if (hour >= 18 && hour < 19) {
    return 'Jangan lupa \nsolat Maghrib!';
  } else if (hour >= 19 && hour < 24) {
    return 'Jangan Lupa \nsolat Isya!';
  }
  return 'Jangan lupa \nsolat Shubuh!';
}

String formattingTimeOfDay(TimeOfDay timeOfDay) {
  final now = DateTime.now();
  final date = DateTime(
    now.year,
    now.month,
    now.day,
    timeOfDay.hour,
    timeOfDay.minute,
  );
  final format = DateFormat.jm();
  return format.format(date);
}

TextStyle kTextStyleBoldBlack(double size) {
  return GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: size,
      color: Colors.black,
      fontWeight: FontWeight.normal,
    ),
  );
}

TextStyle kTextStyleBlack(double size) {
  return GoogleFonts.arimaMadurai(
    textStyle: TextStyle(
      fontSize: size,
      color: Colors.black,
    ),
  );
}

TextStyle kTextStyleBoldGrey(double size) {
  return GoogleFonts.arimaMadurai(
    textStyle: TextStyle(
      fontSize: size,
      color: Colors.grey,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget kVerticalSpace(double height) => SizedBox(height: height);
