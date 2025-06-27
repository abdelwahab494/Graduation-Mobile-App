import 'package:flutter/material.dart';

class CollectInfoProvider extends ChangeNotifier {
  ///// variables /////
  int? _age;
  int? _education;
  int? _income;
  /////////////////////
  int _height = 0;
  int _weight = 0;
  double? _bmi;
  int? _genHealth;
  int _physHealth = 0;
  /////////////////////
  int? _physActivity;
  int? _diffWalk;
  /////////////////////
  int _recentGL = 0;
  int? _highBP;
  int? _highChol;
  int? _stroke;
  int? _heartAttack;

  ////// getters //////
  int? get age => _age;
  int? get education => _education;
  int? get income => _income;
  /////////////////////
  int get height => _height;
  int get weight => _weight;
  double? get bmi => _bmi;
  int? get genHealth => _genHealth;
  int get physHealth => _physHealth;
  /////////////////////
  int? get physActivity => _physActivity;
  int? get diffWalk => _diffWalk;
  /////////////////////
  int get recentGL => _recentGL;
  int? get highBP => _highBP;
  int? get highChol => _highChol;
  int? get stroke => _stroke;
  int? get heartAttack => _heartAttack;

  ////// setters //////
  set age(int? value) {
    _age = value;
    notifyListeners();
  }

  set education(int? value) {
    _education = value;
    notifyListeners();
  }

  set income(int? value) {
    _income = value;
    notifyListeners();
  }

  /////////////////////////////
  set height(int value) {
    _height = value;
    _calculateBMI();
    notifyListeners();
  }

  set weight(int value) {
    _weight = value;
    _calculateBMI();
    notifyListeners();
  }

  set genHealth(int? value) {
    _genHealth = value;
    notifyListeners();
  }

  set physHealth(int value) {
    _physHealth = value;
    notifyListeners();
  }

  /////////////////////////////
  set physActivity(int? value) {
    _physActivity = value;
    notifyListeners();
  }

  set diffWalk(int? value) {
    _diffWalk = value;
    notifyListeners();
  }

  /////////////////////////////
  set recentGL(int value) {
    _recentGL = value;
    notifyListeners();
  }

  set highBP(int? value) {
    _highBP = value;
    notifyListeners();
  }

  set highChol(int? value) {
    _highChol = value;
    notifyListeners();
  }

  set stroke(int? value) {
    _stroke = value;
    notifyListeners();
  }

  set heartAttack(int? value) {
    _heartAttack = value;
    notifyListeners();
  }

  // Functions
  void _calculateBMI() {
    if (_height > 0) {
      // Convert height from cm to meters
      double heightInMeters = _height / 100;
      _bmi = _weight / (heightInMeters * heightInMeters);
    }
    notifyListeners();
  }

  void reset() {
    _age = null;
    _education = null;
    _income = null;
    _height = 0;
    _weight = 0;
    _bmi = null;
    _genHealth = null;
    _physHealth = 0;
    _physActivity = null;
    _diffWalk = null;
    _recentGL = 0;
    _highBP = null;
    _highChol = null;
    _stroke = null;
    _heartAttack = null;
    notifyListeners();
  }
}
