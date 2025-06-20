import 'package:flutter/material.dart';

class AppColors {
  static Color primary = const Color(0xff407CE2);
  static Color backGround = Colors.white;
  static Color text = Colors.black;
  static Color logo = const Color(0xff223A6A);

  static void updateColors(bool isLight) {
    if (isLight) {
      primary = const Color(0xff407CE2);
      backGround = Colors.white;
      text = Colors.black;
      logo = const Color(0xff223A6A);
    } else {
      primary = const Color(0xff407CE2);
      backGround = const Color(0xFF121212);
      text = Colors.white;
      logo = const Color(0xFFE0E0E0);
    }
  }
}
