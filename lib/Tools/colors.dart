import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  static Color primary = Color(0xff407CE2);
  static Color logo = Color(0xff223A6A);
}

// Light Theme
ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white, // خلفية بيضاء
    primaryColor: const Color(0xff407CE2), // اللون الأزرق الأساسي
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black), // نص أسود
      bodyMedium: TextStyle(color: Colors.black),
      titleLarge: TextStyle(color: Colors.black),
      // ممكن تضيف أي أنماط نصوص إضافية هنا
    ),
    colorScheme: ColorScheme.light(
      primary: const Color(0xff407CE2), // اللون الأزرق
      onPrimary: Colors.white, // لون النص ع الأزرق
      surface: Colors.white, // الأسطح بيضاء
      onSurface: Colors.black, // النص ع الأسطح أسود
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white, // خلفية الـ AppBar بيضاء
      foregroundColor: Colors.black, // لون الأيقونات والنصوص في الـ AppBar أسود
    ),
  );
}

// Dark Theme
ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.grey[900], // خلفية غامقة
    primaryColor: const Color(0xff407CE2), // اللون الأزرق زي ما هو
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white), // نص أبيض
      bodyMedium: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white),
      // ممكن تضيف أي أنماط نصوص إضافية هنا
    ),
    colorScheme: ColorScheme.dark(
      primary: const Color(0xff407CE2), // اللون الأزرق
      onPrimary: Colors.white, // لون النص ع الأزرق
      surface: Colors.grey[850]!, // الأسطح غامقة
      onSurface: Colors.white, // النص ع الأسطح أبيض
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[900], // خلفية الـ AppBar غامقة
      foregroundColor: Colors.white, // لون الأيقونات والنصوص في الـ AppBar أبيض
    ),
  );
}