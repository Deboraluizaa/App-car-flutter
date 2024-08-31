import 'package:flutter/material.dart';

final ThemeData themeData = ThemeData(
  primaryColor: const Color.fromARGB(255, 241, 239, 239),
  scaffoldBackgroundColor: const Color.fromARGB(255, 250, 247, 247),
  appBarTheme: AppBarTheme(
    color: const Color.fromARGB(255, 243, 239, 239),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
    bodyMedium: TextStyle(color: const Color.fromARGB(255, 5, 5, 5)),
    bodySmall: TextStyle(color: const Color.fromARGB(255, 22, 22, 22)),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.yellow,
    textTheme: ButtonTextTheme.primary,
  ),
  iconTheme: IconThemeData(
    color: Colors.yellow,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.yellow,
  ),
  bottomAppBarTheme: BottomAppBarTheme(
    color: Colors.black,
  ),
  dividerTheme: DividerThemeData(
    color: Colors.white,
  ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.yellow),
);
