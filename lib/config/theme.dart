import 'package:flutter/material.dart';

ThemeData theme({required bool isDark}) {
  return ThemeData(
      primaryColor: primaryColor(isDark),
      appBarTheme: AppBarTheme(
          color: !isDark ? const Color(0xff111111) : const Color(0xffc0c0f2)),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: const Color(0xffe6e6fa),
      ),
      scaffoldBackgroundColor: isDark ? Colors.white : const Color(0xff000000),
      fontFamily: 'Nunito',
      canvasColor: canvasColor(isDark),
      cardColor: !isDark
          ? const Color.fromARGB(255, 8, 8, 8)
          : const Color.fromARGB(255, 250, 250, 250),
      bottomAppBarColor: bottomAppBarColor(isDark),
      indicatorColor: indicatorColor(isDark),
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      }),
      iconTheme: iconTheme(isDark),
      textTheme: textTheme(isDark: isDark));
}

Color indicatorColor(bool isDark) {
  return !isDark ? Colors.white : const Color(0xff000000);
}

Color primaryColor(bool isDark) {
  return const Color(0xffc0c0f2);
}

Color canvasColor(bool isDark) {
  return isDark ? Colors.white : const Color(0xff000000);
}

IconThemeData iconTheme(bool isDark) {
  return IconThemeData(color: isDark ? Colors.white : Colors.black);
}

Color bottomAppBarColor(bool isDark) {
  return isDark ? Colors.white : const Color(0xff000000);
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
