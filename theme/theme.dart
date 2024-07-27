import 'package:flutter/material.dart';

class DoDidDoneTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF9f7bf6), // Primary color
      brightness: Brightness.light,
      primary: const Color(0xFF9f7bf6), // Primary color
      onPrimary: Colors.white,
      secondary: const Color(0xFF4ceb8b), // Secondary color
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      background: const Color(0xFF9f7bf6), // Background color
      onBackground: Colors.white,
      surface: const Color(0xFF4ceb8b), // Surface color
      onSurface: Colors.white,
    ),
    useMaterial3: true,
  );
}
