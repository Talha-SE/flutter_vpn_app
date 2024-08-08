import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.blueGrey[900],
  scaffoldBackgroundColor: Colors.black87,
  fontFamily: 'OpenSans', // Apply Open Sans font globally
  appBarTheme: AppBarTheme(
    color: Colors.blueGrey[900],
    elevation: 0, // No shadow
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  textTheme: TextTheme(
    displayLarge: const TextStyle(
      color: Colors.white,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ).copyWith(fontFamily: 'OpenSans'),
    displayMedium: const TextStyle(
      color: Colors.white,
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ).copyWith(fontFamily: 'OpenSans'),
    displaySmall: const TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ).copyWith(fontFamily: 'OpenSans'),
    headlineMedium: const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ).copyWith(fontFamily: 'OpenSans'),
    headlineSmall: const TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ).copyWith(fontFamily: 'OpenSans'),
    titleLarge: const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ).copyWith(fontFamily: 'OpenSans'),
    bodyLarge: TextStyle(
      color: Colors.grey[300],
      fontSize: 14,
    ).copyWith(fontFamily: 'OpenSans'),
    bodyMedium: const TextStyle(
      color: Colors.white70,
      fontSize: 12,
    ).copyWith(fontFamily: 'OpenSans'),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white, // Text color
      backgroundColor: const Color.fromARGB(255, 157, 234, 236),
    ),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blueGrey,
    brightness: Brightness.dark,
    primary: Colors.blueGrey[900]!,
    secondary: const Color.fromARGB(255, 171, 245, 255),
  ),
);
