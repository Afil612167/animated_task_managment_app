import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFF5097D1),
    // acc: Color(0xFF6B82BA),
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black, fontSize: 16),
      bodyMedium: TextStyle(color: Colors.black54, fontSize: 14),
    ),
    cardColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF5097D1),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xFF1E1E2C),
    // accentColor: Color(0xFF3E497A),
    scaffoldBackgroundColor: Color(0xFF121212),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
      bodyMedium: TextStyle(color: Colors.white70, fontSize: 14),
    ),
    cardColor: Color(0xFF1F1F1F),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF1E1E2C),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
    ),
  );
}
