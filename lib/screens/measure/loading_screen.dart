import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/providers/measure_provider.dart';
import 'package:grad_project/screens/measure/measurement_page.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    Provider.of<MeasureProvider>(
      context,
      listen: false,
    ).connectToESP32(context);
    super.initState();
  }

  // @override
  // void dispose() {
  //   connection?.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<MeasureProvider>(
      builder: (context, provider, child) {
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
                    if (!provider.isConnected) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (c) => MeasurementPage()),
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
      },
    );
  }
}
