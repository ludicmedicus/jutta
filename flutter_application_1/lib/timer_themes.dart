import 'package:flutter/material.dart';
const Color myFirstColor = Color.fromARGB(255, 129, 51, 137);
const Color mySecondColor = Color.fromARGB(255, 92, 43, 132);
ColorScheme lightScheme = ColorScheme.fromSeed(seedColor: myFirstColor);
ColorScheme darkScheme = ColorScheme.fromSeed(seedColor: myFirstColor);
ThemeData lightTheme = ThemeData(
        colorScheme: .fromSeed(seedColor: myFirstColor,
        brightness: Brightness.light),
        useMaterial3: true,
      );
ThemeData darkTheme = ThemeData(
        colorScheme: .fromSeed(seedColor: myFirstColor,
        brightness: Brightness.dark),
        useMaterial3: true,
      );