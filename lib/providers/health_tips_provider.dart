import 'package:flutter/material.dart';
import 'package:grad_project/database/user_health_data/user_health_data.dart';
import 'package:grad_project/screens/chatbot/chatbot.dart';

class HealthTipsProvider with ChangeNotifier {
  List<String> _healthTips = [];
  bool _isLoadingTips = false;
  Map data = {
    "Age": [
      "18 : 24",
      "25 : 29",
      "30 : 34",
      "35 : 39",
      "40 : 44",
      "45 : 49",
      "50 : 54",
      "55 : 59",
      "60 : 64",
      "65 : 69",
      "70 : 74",
      "75 : 79",
      "> 80",
    ],
    "Gen Health": ["Excellent", "Very good", "Good", "Fair", "Poor"],
  };

  List<String> get healthTips => _healthTips;
  bool get isLoadingTips => _isLoadingTips;

  Future<void> fetchHealthTips(UserHealthData? userdata) async {
    _isLoadingTips = true;
    notifyListeners();

    try {
      int retryCount = 0;
      const maxRetries = 3;

      while (retryCount < maxRetries) {
        try {
          final tips = await Chatbot.getHealthTips(
            age: data["Age"][userdata!.age.toInt() - 1],
            highbp: userdata.highbp == 0 ? "Don't Have" : "Have",
            highcol: userdata.highcol == 0 ? "Don't Have" : "Have",
            bmi: userdata.bmi.toString(),
            heartAttack: userdata.heartattack == 0 ? "Don't Have" : "Have",
            physActivity: userdata.physactivity == 0 ? "Doesn't Do" : "Doing",
            genHealth: data["Gen Health"][userdata.genhealth.toInt() - 1],
            diffWalk: userdata.diffwalk == 0 ? "Don't Have" : "Have",
            medicalCondition:
                userdata.predictionStatus == 0 ? "Not Diabetes" : "Diabetes",
          );
          _healthTips = tips;
          break; 
        } catch (e) {
          retryCount++;
          if (retryCount == maxRetries) throw e;
          await Future.delayed(
            Duration(seconds: 2),
          );
        }
      }

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
