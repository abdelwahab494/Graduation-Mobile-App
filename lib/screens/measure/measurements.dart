import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/components/custom_app_bar.dart';
import 'package:intl/intl.dart';

class MeasurementScreen extends StatefulWidget {
  const MeasurementScreen({super.key});

  @override
  State<MeasurementScreen> createState() => _MeasurementScreenState();
}

class _MeasurementScreenState extends State<MeasurementScreen> {
  int glucose = 120;
  String status = "Normal";
  Color statusColor = Colors.green;
  DateTime? measuredAt;



  updateReading(int newReading) {
    setState(() {
      glucose = newReading;
      measuredAt = DateTime.now();
      if (glucose > 140) {
        status = "High";
        statusColor = Colors.red;
      } else if (glucose < 100) {
        status = "Low";
        statusColor = Colors.orange;
      } else {
        status = "Normal";
        statusColor = Colors.green;
      }
    });
  }

  navigateToMeasure() async {
    final newReading = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MeasuringPage()),
    );

    if (newReading != null && newReading is int) {
      updateReading(newReading);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      appBar: CustomAppBar(title: "GlucoMate"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text("Latest Reading"),
                    Text(
                      "$glucose mg/dL",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                        fontFamily: GoogleFonts.roboto().fontFamily,
                      ),
                    ),
                    Gap(4),
                    Text(
                      measuredAt != null
                          ? DateFormat('MMM d, h:mm a').format(measuredAt!)
                          : "No reading yet",
                      style: TextStyle(color: Colors.grey),
                    ),

                    Gap(6),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(status, style: TextStyle(color: statusColor)),
                    ),
                    Gap(16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: 40,
                        color: statusColor.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(24),
              Text("Quick Actions"),
              Gap(8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: navigateToMeasure,
                  icon: Icon(Icons.add_circle_outline, color: Colors.white),
                  label: Text(
                    "Measure Again",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              Gap(24),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "7-Day Overview",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("7 Days", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    Gap(100),
                    SizedBox(
                      height: 150,
                      child: LineChart(
                        LineChartData(
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: const [
                                FlSpot(0, 130),
                                FlSpot(1, 110),
                                FlSpot(2, 125),
                                FlSpot(3, 140),
                                FlSpot(4, 115),
                                FlSpot(5, 125),
                                FlSpot(6, 120),
                              ],
                              isCurved: true,
                              color: AppColors.primary,
                              barWidth: 3,
                              isStrokeCapRound: true,
                              dotData: FlDotData(show: true),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MeasuringPage extends StatefulWidget {
  const MeasuringPage({super.key});

  @override
  State<MeasuringPage> createState() => _MeasuringPageState();
}

class _MeasuringPageState extends State<MeasuringPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () async {
      final newReading = await showDialog<int>(
        context: context,
        builder: (context) {
          final controller = TextEditingController();
          return AlertDialog(
            title: Text("Enter Glucose Reading"),
            content: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Glucose is ?"),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  final val = int.tryParse(controller.text);
                  if (val != null) {
                    Navigator.pop(context, val);
                  }
                },
                child: Text("Submit"),
              ),
            ],
          );
        },
      );

      if (mounted) Navigator.pop(context, newReading);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitFadingCircle(color: Colors.blue, size: 50.0),
            SizedBox(height: 20),
            Text("Measuring Glucose...", style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
