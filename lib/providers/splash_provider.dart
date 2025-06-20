import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashProvider extends ChangeNotifier {
  bool _splash = true;

  bool get splash => _splash;

  SplashProvider() {
    loadSplashValue();
  }

  Future<void> loadSplashValue() async {
    final prefs = await SharedPreferences.getInstance();
    _splash = prefs.getBool("HideSplashValue") ?? true;
    notifyListeners();
  }

  Future<void> hideSplash() async {
    _splash = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("HideSplashValue", false);
    notifyListeners();
  }
}