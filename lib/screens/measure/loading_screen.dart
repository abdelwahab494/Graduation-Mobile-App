import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:gap/gap.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/screens/measure/measurement_page.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  BluetoothConnection? connection;
  String espName = "ESP32_GlucoseMonitor";
  num voltage = 0;
  num glucose = 0;
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    _connectToESP32();
  }

  Future<void> _connectToESP32() async {
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
      (d) => d.name == espName,
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
        ),
      );
      await Future.delayed(Duration(seconds: 5), () {
        Navigator.pop(context);
      });
      return;
    }

    try {
      connection = await BluetoothConnection.toAddress(espDevice.address);
      print('Connected to the device');
      setState(() => isConnected = true);

      connection!.input!.listen((data) async {
        final message = String.fromCharCodes(data).trim();
        print("📩 Data received: $message");
        if (message.contains(",")) {
          final parts = message.split(",");
          try {
            final parsedVoltage = num.parse(parts[0]);
            final parsedGlucose = num.parse(parts[1]);

            setState(() {
              voltage = parsedVoltage;
              glucose = parsedGlucose;
            });
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
              ),
            );
            await Future.delayed(Duration(seconds: 5), () {
              Navigator.pop(context);
            });
          }
        }
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
        ),
      );
      await Future.delayed(Duration(seconds: 5), () {
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

  @override
  void dispose() {
    connection?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.network(
              "https://lottie.host/d96ad297-acf0-486e-ad5f-4d48d36473e0/0NCCEONPnw.json",
            ),
            Gap(10),
            LinearPercentIndicator(
              animation: true,
              animationDuration: 17000,
              animateFromLastPercent: true,
              onAnimationEnd: () async {
                if (isConnected) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder:
                          (c) => MeasurementPage(
                            reading: glucose,
                            function: sendMeasureCommand,
                          ),
                    ),
                  );
                }
              },
              barRadius: Radius.circular(20),
              lineHeight: 30,
              percent: 1,
              progressColor: AppColors.primary,
              backgroundColor: Color(0xFFC4DAFF),
            ),
          ],
        ),
      ),
    );
  }
}
