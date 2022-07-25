import 'package:flutter/material.dart';

ThemeData theme({required bool isDark}) {
  return ThemeData(
      scaffoldBackgroundColor: isDark ? Colors.white : Color(0xff111111),
      fontFamily: 'Nunito',
      canvasColor: canvasColor(isDark),
      cardColor: !isDark
          ? Color.fromARGB(255, 20, 20, 20)
          : Color.fromARGB(255, 250, 250, 250),
      bottomAppBarColor: bottomAppBarColor(isDark),
      indicatorColor: indicatorColor(isDark),
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.iOS: const CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: const CupertinoPageTransitionsBuilder(),
      }),
      iconTheme: iconTheme(isDark),
      textTheme: textTheme(isDark: isDark));
}

Color indicatorColor(bool isDark) {
  return !isDark ? Colors.white : Colors.black;
}

Color canvasColor(bool isDark) {
  return isDark ? Colors.white : Color(0xff111111);
}

IconThemeData iconTheme(bool isDark) {
  return IconThemeData(color: isDark ? Colors.white : Colors.black);
}

Color bottomAppBarColor(bool isDark) {
  return isDark ? Colors.white : Color.fromARGB(255, 14, 13, 13);
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
