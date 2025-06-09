import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeThemeProvider extends ChangeNotifier {
  bool _isLight = true;

  bool get isLight => _isLight;

  // Constructor to load the saved theme when the provider is created
  ChangeThemeProvider() {
    _loadTheme();
  }

  // Load the saved theme from SharedPreferences
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isLight =
        prefs.getBool('isLight') ??
        true; // Default to true if no value is found
    notifyListeners();
  }

  // Save the theme in the SharedPreferences and toggle it
  Future<void> changeTheme() async {
    _isLight = !_isLight;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLight", _isLight);
    notifyListeners();
  }
}
