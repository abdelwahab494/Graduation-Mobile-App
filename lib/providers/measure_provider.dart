import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:grad_project/core/colors.dart';
import 'package:permission_handler/permission_handler.dart';

class MeasureProvider extends ChangeNotifier {
  BluetoothConnection? _connection;
  String _espName = "ESP32_GlucoseMonitor";
  num _voltage = 0;
  num _glucose = 0;
  bool _isConnected = false;
  String _rating = "";
  Color _color = AppColors.primary;
  Color _bColor = AppColors.backGround;

  BluetoothConnection? get connection => _connection;
  String get espName => _espName;
  num get voltage => _voltage;
  num get glucose => _glucose;
  bool get isConnected => _isConnected;
  String get rating => _rating;
  Color get color => _color;
  Color get bColor => _bColor;

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
      await Future.delayed(Duration(seconds: 5), () {
        Navigator.pop(context);
      });
      return;
    }

    final espDevice = devices.firstWhere(
      (d) => d.name == _espName,
      orElse: () => BluetoothDevice(address: ""),
    );

    if (espDevice.address.isEmpty) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     backgroundColor: const Color.fromARGB(220, 255, 17, 0),
      //     content: Text(
      //       "Error: \nConnection Failed!\nPlease Make sure your Glucose Device is on.",
      //       style: TextStyle(
      //         color: Colors.white,
      //         fontSize: 16,
      //         fontWeight: FontWeight.w600,
      //       ),
      //     ),
      //   ),
      // );
      // await Future.delayed(Duration(seconds: 5), () {
      //   Navigator.pop(context);
      // });
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
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     backgroundColor: const Color.fromARGB(220, 255, 17, 0),
            //     content: Text(
            //       "Error: \nInvalid Readings! \nPlease try again.",
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 16,
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //   ),
            // );
            // await Future.delayed(Duration(seconds: 5), () {
            //   Navigator.pop(context);
            // });
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
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     backgroundColor: const Color.fromARGB(220, 255, 17, 0),
      //     content: Text(
      //       "Error: \nConnection Failed!\nPlease Try Again.",
      //       style: TextStyle(
      //         color: Colors.white,
      //         fontSize: 16,
      //         fontWeight: FontWeight.w600,
      //       ),
      //     ),
      //   ),
      // );
      // await Future.delayed(Duration(seconds: 5), () {
      //   Navigator.pop(context);
      // });
      return;
    }
  }

  // void sendMeasureCommand() {
  //   if (connection != null && isConnected) {
  //     connection!.output.add(Uint8List.fromList("MEASURE\n".codeUnits));
  //     connection!.output.allSent;
  //     print('✅ Sent: MEASURE');
  //   }
  // }

  void updateRatingAndColors() {
    if (_glucose <= 54) {
      _rating = "Severe Low";
      _color = Colors.red.shade700;
      _bColor = Colors.red.shade100;
    } else if (_glucose < 70 && _glucose > 54) {
      _rating = "Low";
      _color = Colors.orange;
      _bColor = Colors.orange.shade100;
    } else if (_glucose >= 70 && _glucose <= 140) {
      _rating = "Normal";
      _color = Colors.green;
      _bColor = Colors.green.shade100;
    } else if (_glucose > 140 && _glucose < 220) {
      _rating = "High";
      _color = Colors.orange;
      _bColor = Colors.orange.shade100;
    } else {
      _rating = "Severe High";
      _color = Colors.red.shade700;
      _bColor = Colors.red.shade100;
    }
  }
}
