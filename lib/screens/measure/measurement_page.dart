import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/components/custom_app_bar.dart';
import 'package:grad_project/components/custom_botton.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/providers/measure_provider.dart';
import 'package:grad_project/screens/measure/loading_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MeasurementPage extends StatefulWidget {
  MeasurementPage({super.key});

  @override
  State<MeasurementPage> createState() => _MeasurementPageState();
}

class _MeasurementPageState extends State<MeasurementPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<MeasureProvider>(
      context,
      listen: false,
    ).updateRatingAndColors();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDateTime =
        DateFormat('EEEE,  hh:mm a').format(now).toString();

    return Consumer<MeasureProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: AppColors.backGround,
          appBar: CustomAppBar(title: ""),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Glucose Reading",
                          style: GoogleFonts.poppins(
                            color: AppColors.text,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              provider.glucose.toString(),
                              style: GoogleFonts.poppins(
                                color: provider.color,
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 3,
                              ),
                            ),
                            Gap(3),
                            Padding(
                              padding: const EdgeInsets.only(top: 22),
                              child: Text(
                                "mg/dl",
                                style: GoogleFonts.poppins(
                                  color: Colors.grey.shade600,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          formattedDateTime,
                          style: GoogleFonts.poppins(
                            color: Colors.grey.shade700,
                            fontSize: 13,
                          ),
                        ),
                        Gap(20),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: provider.bColor,
                            border: Border.all(
                              color: provider.color,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            provider.rating.toString(),
                            style: GoogleFonts.poppins(
                              color: provider.color,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                          width: double.infinity,
                          child: CustomPaint(painter: WavePainter()),
                        ),
                      ],
                    ),
                  ),
                  Gap(35),
                  CustomBotton(
                    onTap: () {
                      // provider.connectToESP32(context);
                      // provider.sendMeasureCommand();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (c) => LoadingScreen()),
                      );
                    },
                    text: "Measure Again",
                    width: double.infinity,
                  ),
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          width: 160,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.primary,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            "Cancel",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(15),
                          width: 160,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: AppColors.primary,
                              width: 2,
                            ),
                          ),
                          child: Text(
                            "Save",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(35),
                  Text(
                    "Glucose Trends",
                    style: GoogleFonts.poppins(
                      color: AppColors.text,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gap(10),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "7-Day Overview",
                          style: GoogleFonts.poppins(
                            color: AppColors.text,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Gap(10),
                        SizedBox(
                          height: 200,
                          child: LineChart(
                            LineChartData(
                              borderData: FlBorderData(show: false),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: const [
                                    FlSpot(0, 130),
                                    FlSpot(1, 120),
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
                  Gap(25),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.blue
          ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.5);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.7,
      size.width * 0.5,
      size.height * 0.6,
    ); // Higher curve
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.5,
      size.width,
      size.height * 0.6,
    ); // Higher curve
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
