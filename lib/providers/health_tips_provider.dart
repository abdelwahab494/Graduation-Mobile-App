import 'package:flutter/material.dart';
import 'package:grad_project/screens/chatbot/chatbot.dart';

class HealthTipsProvider with ChangeNotifier {
  List<String> _healthTips = [];
  bool _isLoadingTips = false;

  List<String> get healthTips => _healthTips;
  bool get isLoadingTips => _isLoadingTips;

  Future<void> fetchHealthTips({
    required String age,
    required String gender,
    required String medicalCondition,
    required String lifestyle,
  }) async {
    _isLoadingTips = true;
    notifyListeners();

    try {
      final tips = await Chatbot.getHealthTips(
        age: age,
        gender: gender,
        medicalCondition: medicalCondition,
        lifestyle: lifestyle,
      );

      _healthTips = tips;
      _isLoadingTips = false;
      notifyListeners();
    } catch (e) {
      _isLoadingTips = false;
      notifyListeners();
      throw e;
    }
  }

  void clearHealthTips() {
    _healthTips = [];
    _isLoadingTips = false;
    notifyListeners();
  }
}