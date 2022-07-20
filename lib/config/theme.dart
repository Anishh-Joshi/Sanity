import 'package:flutter/material.dart';

ThemeData theme({required bool isDark}) {
  return ThemeData(
      scaffoldBackgroundColor: isDark ? Colors.white : Color(0xff111111),
      fontFamily: 'Nunito',
      pageTransitionsTheme: PageTransitionsTheme(builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      }),
      textTheme: textTheme(isDark: isDark));
}

TextTheme textTheme({required bool isDark}) {
  return TextTheme(
      headline1: TextStyle(
        color: !isDark ? Colors.white : Colors.black,
        fontSize: 32,
        fontWeight: FontWeight.w900,
      ),
      headline2: TextStyle(
        color: !isDark ? Colors.white : Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.w800,
      ),
      headline3: TextStyle(
        color: !isDark ? Colors.white : Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
      headline4: TextStyle(
        color: !isDark ? Colors.white : Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      headline5: TextStyle(
        color: !isDark ? Colors.white : Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      headline6: TextStyle(
        color: !isDark ? Colors.white : Colors.black,
        fontSize: 10,
        fontWeight: FontWeight.w400,
      ),
      bodyText1: TextStyle(
        color: !isDark ? Colors.white : Colors.black,
        fontSize: 12,
        fontWeight: FontWeight.w300,
      ),
      bodyText2: TextStyle(
        color: !isDark ? Colors.white : Colors.black,
        fontSize: 10,
        fontWeight: FontWeight.w200,
      ));
}
