import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:grad_project/auth/auth_service.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/database/glucose_measurements/glucose_measurements.dart';
import 'package:grad_project/database/glucose_measurements/glucose_measurements_database.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MeasureProvider extends ChangeNotifier {
  BluetoothConnection? _connection;
  String _espName = "ESP32_GlucoseMonitor";
  num _voltage = 0.43;
  num _glucose = 136;
  bool _isConnected = false;
  String _rating = "";
  Color _color = AppColors.primary;
  Color _bColor = AppColors.backGround;
  IconData _icon = CupertinoIcons.question_circle_fill;
  String _feedbackResult = "";

  BluetoothConnection? get connection => _connection;
  String get espName => _espName;
  num get voltage => _voltage;
  num get glucose => _glucose;
  bool get isConnected => _isConnected;
  String get rating => _rating;
  Color get color => _color;
  Color get bColor => _bColor;
  IconData get icon => _icon;
  String get feedbackResult => _feedbackResult;

  set voltage(num value) {
    _voltage = value;
    notifyListeners();
  }

  set glucose(num value) {
    _glucose = value;
    notifyListeners();
  }

  set isConnected(bool value) {
    _isConnected = value;
    notifyListeners();
  }

  set color(Color value) {
    _color = value;
    notifyListeners();
  }

  set bColor(Color value) {
    _bColor = value;
    notifyListeners();
  }

  set rating(String value) {
    _rating = value;
    updateRatingAndColors();
    notifyListeners();
  }

  Future<void> connectToESP32(context) async {
    if (_connection != null && _isConnected) {
      await _connection!.close();
      _connection?.dispose();
      _isConnected = false;
      notifyListeners();
      print("Closed existing connection");
    }

    await Permission.bluetoothScan.request();
    await Permission.bluetoothConnect.request();
    await Permission.location.request();

    List<BluetoothDevice> devices = [];
    try {
      devices = await FlutterBluetoothSerial.instance.getBondedDevices();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color.fromARGB(220, 255, 17, 0),
          content: Text(
            "Error: \nConnection Failed!\nPlease Make sure your Bluetooth is on.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
      await Future.delayed(Duration(seconds: 4), () {
        Navigator.pop(context);
      });
      return;
    }

    final espDevice = devices.firstWhere(
      (d) => d.name == _espName,
      orElse: () => BluetoothDevice(address: ""),
    );

    if (espDevice.address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color.fromARGB(220, 255, 17, 0),
          content: Text(
            "Error: \nConnection Failed!\nPlease Make sure your Glucose Device is on.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          duration: Duration(seconds: 3),
        ),
      );
      await Future.delayed(Duration(seconds: 4), () {
        Navigator.pop(context);
      });
      return;
    }

    try {
      _connection = await BluetoothConnection.toAddress(espDevice.address);
      print('Connected to the device');
      _isConnected = true;
      notifyListeners();

      if (_connection != null && _isConnected) {
        connection!.output.add(Uint8List.fromList("MEASURE\n".codeUnits));
        connection!.output.allSent;
        print('✅ Sent: MEASURE');
      }

      connection!.input!.listen((data) async {
        final message = String.fromCharCodes(data).trim();
        print("📩 Data received: $message");
        if (message.contains(",")) {
          final parts = message.split(",");
          try {
            final parsedVoltage = num.parse(parts[0]);
            final parsedGlucose = num.parse(parts[1]);

            _voltage = parsedVoltage;
            _glucose = parsedGlucose;
            notifyListeners();
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: const Color.fromARGB(220, 255, 17, 0),
                content: Text(
                  "Error: \nInvalid Readings! \nPlease try again.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                duration: Duration(seconds: 3),
              ),
            );
            await Future.delayed(Duration(seconds: 4), () {
              Navigator.pop(context);
            });
            return;
          }
        }
        // if (_connection != null && _isConnected) {
        //   await _connection!.close();
        //   _connection?.dispose();
        //   _isConnected = false;
        //   notifyListeners();
        //   print("Closed existing connection");
        // }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color.fromARGB(220, 255, 17, 0),
          content: Text(
            "Error: \nConnection Failed!\nPlease Try Again.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          duration: Duration(seconds: 3),
          showCloseIcon: true,
        ),
      );
      await Future.delayed(Duration(seconds: 4), () {
        Navigator.pop(context);
      });
      return;
    }
  }

  void sendMeasureCommand() {
    if (connection != null && isConnected) {
      connection!.output.add(Uint8List.fromList("MEASURE\n".codeUnits));
      connection!.output.allSent;
      print('✅ Sent: MEASURE');
    }
  }

  void updateRatingAndColors() {
    if (_glucose <= 54) {
      _rating = "Severe Low";
      _icon = Icons.warning_rounded;
      _color = Colors.red.shade700;
      _bColor = Colors.red.shade100;
    } else if (_glucose < 70 && _glucose > 54) {
      _rating = "Low";
      _icon = CupertinoIcons.arrow_down_circle_fill;
      _color = Colors.orange;
      _bColor = Colors.orange.shade100;
    } else if (_glucose >= 70 && _glucose <= 140) {
      _rating = "Normal";
      _icon = CupertinoIcons.checkmark_alt_circle_fill;
      _color = Colors.green;
      _bColor = Colors.green.shade100;
    } else if (_glucose > 140 && _glucose < 220) {
      _rating = "High";
      _icon = CupertinoIcons.arrow_up_circle_fill;
      _color = Colors.orange;
      _bColor = Colors.orange.shade100;
    } else {
      _rating = "Severe High";
      _icon = Icons.warning_rounded;
      _color = Colors.red.shade700;
      _bColor = Colors.red.shade100;
    }
  }

  Future<void> saveMeasurementToDatabase() async {
    final userId = AuthService().getCurrentId();
    if (userId == null) throw Exception('No user logged in');

    final measurement = GlucoseMeasurements(
      userid: userId,
      created_at: DateTime.now(),
      glucose: _glucose.toDouble(),
      voltage: _voltage.toDouble(),
      agree: AuthService().getCurrentItemBool("agree"),
      feedback: null,
    );

    final db = GlucoseMeasurementsDatabase();
    await db.createUserHealthData(measurement);
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
              .from('glucose_measurements')
              .select('created_at')
              .eq('userid', userId)
              .order('created_at', ascending: false)
              .limit(1)
              .single();

      final createdAt = response['created_at'];

      // Update the feedback for the latest record
      await Supabase.instance.client
          .from('glucose_measurements')
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
