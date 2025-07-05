import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grad_project/auth/auth_service.dart';
import 'package:grad_project/database/user_health_data/user_health_data.dart';
import 'package:grad_project/database/user_health_data/user_health_database.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

class CollectInfoProvider extends ChangeNotifier {
  ///// variables /////
  int _age = 0;
  int _education = 0;
  int _income = 0;
  /////////////////////
  int _height = 0;
  int _weight = 0;
  double _bmi = 0;
  int _genHealth = 0;
  int _physHealth = 0;
  /////////////////////
  int _physActivity = 0;
  int _diffWalk = 0;
  /////////////////////
  int _recentGL = 0;
  int _highBP = 0;
  int _highChol = 0;
  int _stroke = 0;
  int _heartAttack = 0;
  String _result = '';
  String _feedbackResult = '';
  UserHealthData? _userHealthData;

  ////// getters //////
  int get age => _age;
  int get education => _education;
  int get income => _income;
  /////////////////////
  int get height => _height;
  int get weight => _weight;
  double? get bmi => _bmi;
  int get genHealth => _genHealth;
  int get physHealth => _physHealth;
  /////////////////////
  int get physActivity => _physActivity;
  int get diffWalk => _diffWalk;
  /////////////////////
  int get recentGL => _recentGL;
  int get highBP => _highBP;
  int get highChol => _highChol;
  int get stroke => _stroke;
  int get heartAttack => _heartAttack;
  String get result => _result;
  String get feedbackResult => _feedbackResult;
  UserHealthData? get userHealthData => _userHealthData;

  ////// setters //////
  set age(int value) {
    _age = value;
    notifyListeners();
  }

  set education(int value) {
    _education = value;
    notifyListeners();
  }

  set income(int value) {
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

  set genHealth(int value) {
    _genHealth = value;
    notifyListeners();
  }

  set physHealth(int value) {
    _physHealth = value;
    notifyListeners();
  }

  /////////////////////////////
  set physActivity(int value) {
    _physActivity = value;
    notifyListeners();
  }

  set diffWalk(int value) {
    _diffWalk = value;
    notifyListeners();
  }

  /////////////////////////////
  set recentGL(int value) {
    _recentGL = value;
    notifyListeners();
  }

  set highBP(int value) {
    _highBP = value;
    notifyListeners();
  }

  set highChol(int value) {
    _highChol = value;
    notifyListeners();
  }

  set stroke(int value) {
    _stroke = value;
    notifyListeners();
  }

  set heartAttack(int value) {
    _heartAttack = value;
    notifyListeners();
  }

  set userHealthData(UserHealthData? value) {
    _userHealthData = value;
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

  Future<void> predictFromServer() async {
    List<double> values = [
      _highBP.toDouble(),
      _highChol.toDouble(),
      _bmi.roundToDouble(),
      _stroke.toDouble(),
      _heartAttack.toDouble(),
      _physActivity.toDouble(),
      _genHealth.toDouble(),
      _physHealth.toDouble(),
      _diffWalk.toDouble(),
      _age.toDouble(),
      _education.toDouble(),
      _income.toDouble(),
    ];

    print(values);

    try {
      final response = await http.post(
        Uri.parse(
          'https://diabetes-api-453051824601.me-central1.run.app/predict',
        ),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"values": values}),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        _result = result["prediction"][0].toString();
      } else {
        _result = "Server Error: ${response.statusCode}";
      }
    } catch (e) {
      _result = "Connection Error: $e";
    }

    // Save data to Supabase using createUserHealthData
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) {
        _result = "Error: User not authenticated";
        notifyListeners();
        return;
      }

      final userHealthData = UserHealthData(
        userId: userId,
        highbp: values[0],
        highcol: values[1],
        bmi: values[2],
        stroke: values[3],
        heartattack: values[4],
        physactivity: values[5],
        genhealth: values[6],
        physhealth: values[7],
        diffwalk: values[8],
        age: values[9],
        education: values[10],
        income: values[11],
        predictionStatus: int.tryParse(_result) ?? 0,
        feedback: null,
        agree: AuthService().getCurrentItemBool("agree"),
        createdAt: DateTime.now(),
      );

      await UserHealthDatabase().createUserHealthData(userHealthData);
    } catch (e) {
      _result = "Supabase Error: $e";
    }

    notifyListeners();
  }

  Future<void> submitFeedback(String feedback) async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) {
        _feedbackResult = "Error: User not authenticated";
        notifyListeners();
        return;
      }

      // Get the latest record for the user to update
      final response =
          await Supabase.instance.client
              .from('user_health_data')
              .select('created_at')
              .eq('userid', userId)
              .order('created_at', ascending: false)
              .limit(1)
              .single();

      final createdAt = response['created_at'];

      // Update the feedback for the latest record
      await Supabase.instance.client
          .from('user_health_data')
          .update({'feedback': feedback})
          .eq('userid', userId)
          .eq('created_at', createdAt);

      _feedbackResult = "Feedback submitted successfully";
    } catch (e) {
      _feedbackResult = "Error submitting feedback: $e";
    }
    notifyListeners();
  }
}
