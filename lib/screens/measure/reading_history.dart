import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/auth/auth_service.dart';
import 'package:grad_project/components/custom_app_bar.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/database/glucose_measurements/glucose_measurements.dart';
import 'package:grad_project/database/glucose_measurements/glucose_measurements_database.dart';
import 'package:grad_project/screens/measure/glucose_line_chart.dart';
import 'package:intl/intl.dart';

class ReadingHistory extends StatelessWidget {
  ReadingHistory({super.key});
  final bool isPartner = AuthService().getCurrentItemBool("isPartner");
  final _streamKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final db = GlucoseMeasurementsDatabase();
    return Scaffold(
      backgroundColor: AppColors.backGround,
      appBar: CustomAppBar(
        title: !isPartner ? "Glucose History" : "Your Patient's History",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Gap(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FutureBuilder<double>(
                    future: db.getAverageGlucoseLast7Days(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          width: width * 0.43,
                          height: height * 0.165,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Container(
                          width: width * 0.43,
                          height: height * 0.165,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              'Error',
                              style: GoogleFonts.poppins(
                                color: Colors.red,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      }

                      final avgGlucose = snapshot.data ?? 0.0;
                      return Container(
                        width: width * 0.43,
                        height: height * 0.165,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Color(0xffe6eefb),
                                    borderRadius: BorderRadius.circular(500),
                                  ),
                                  child: Icon(
                                    Icons.av_timer_rounded,
                                    color: AppColors.primary,
                                    size: 22,
                                  ),
                                ),
                                Gap(10),
                                Text(
                                  "Avg\nGlucose",
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Gap(10),
                            FittedBox(
                              child: Text(
                                "${avgGlucose.toStringAsFixed(0)} mg/dl",
                                style: GoogleFonts.poppins(
                                  color: AppColors.text,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  FutureBuilder<int>(
                    future: db.getReadingsCountLast7Days(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          width: width * 0.43,
                          height: height * 0.165,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        print(
                          'FutureBuilder error: ${snapshot.error}',
                        ); // Debug
                        return Container(
                          width: width * 0.43,
                          height: height * 0.165,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              'Error: ${snapshot.error.toString().split(':').last.trim()}',
                              style: GoogleFonts.poppins(
                                color: Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }

                      final readingsCount = snapshot.data ?? 0;
                      return Container(
                        width: width * 0.43,
                        height: height * 0.165,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Color(0xffe6eefb),
                                    borderRadius: BorderRadius.circular(500),
                                  ),
                                  child: Icon(
                                    Icons.numbers,
                                    color: AppColors.primary,
                                    size: 22,
                                  ),
                                ),
                                Gap(10),
                                Text(
                                  "Last 7\nDays",
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Gap(10),
                            FittedBox(
                              child: Text(
                                readingsCount == 0
                                    ? "No Readings"
                                    : "$readingsCount Readings",
                                style: GoogleFonts.poppins(
                                  color: AppColors.text,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              Gap(25),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Color(0xffe6eefb),
                            borderRadius: BorderRadius.circular(500),
                          ),
                          child: Icon(
                            Icons.bar_chart_rounded,
                            color: AppColors.primary,
                            size: 22,
                          ),
                        ),
                        Gap(15),
                        Text(
                          "Daily Trends",
                          style: GoogleFonts.poppins(
                            color: AppColors.text,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Gap(10),
                    Padding(
                      padding: const EdgeInsets.all(1),
                      child: StreamBuilder<List<GlucoseMeasurements>>(
                        stream: GlucoseMeasurementsDatabase().stream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                ),
                                child: CircularProgressIndicator(
                                  color: AppColors.primary,
                                ),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsetsGeometry.symmetric(
                                  vertical: 20,
                                ),
                                child: Text(
                                  'Something went wrong!\n Please check your connection.',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.text,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsetsGeometry.symmetric(
                                  vertical: 20,
                                ),
                                child: Text(
                                  'No saved Readings yet.',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.text,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }

                          final measurements = snapshot.data!;
                          return GlucoseLineChart(measurements: measurements);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Gap(25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    !isPartner
                        ? "Recent Glucose Readings"
                        : "Your Patient's Glucose Readings",
                    style: GoogleFonts.poppins(
                      color: AppColors.text,
                      fontSize: !isPartner ? 16 : 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gap(10),
                  StreamBuilder<List<GlucoseMeasurements>>(
                    key: _streamKey,
                    stream: db.stream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          ),
                        );
                      }
                      if (snapshot.hasError) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Center(
                            child: Text(
                              'Something went wrong!\n Please check your connection.',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.text,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Center(
                            child: Text(
                              'No History yet.',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.text,
                              ),
                            ),
                          ),
                        );
                      }
                      final measurements = snapshot.data!;
                      return Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: measurements.length,
                            itemBuilder: (BuildContext context, int index) {
                              final measurement = measurements[index];
                              Color color;
                              Color bcolor;
                              IconData icon;
                              if (measurement.glucose <= 54) {
                                icon = Icons.warning_rounded;
                                color = Colors.red.shade700;
                                bcolor = Colors.red.shade100;
                              } else if (measurement.glucose < 70 &&
                                  measurement.glucose > 54) {
                                icon = CupertinoIcons.arrow_down_circle_fill;
                                color = Colors.orange;
                                bcolor = Colors.orange.shade100;
                              } else if (measurement.glucose >= 70 &&
                                  measurement.glucose <= 140) {
                                icon = CupertinoIcons.checkmark_alt_circle_fill;
                                color = Colors.green;
                                bcolor = Colors.green.shade100;
                              } else if (measurement.glucose > 140 &&
                                  measurement.glucose < 220) {
                                icon = CupertinoIcons.arrow_up_circle_fill;
                                color = Colors.orange;
                                bcolor = Colors.orange.shade100;
                              } else {
                                icon = Icons.warning_rounded;
                                color = Colors.red.shade700;
                                bcolor = Colors.red.shade100;
                              }
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 15,
                                ),
                                margin: EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: bcolor,
                                        borderRadius: BorderRadius.circular(
                                          500,
                                        ),
                                      ),
                                      child: Icon(icon, color: color, size: 35),
                                    ),
                                    Gap(20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              measurement.glucose.toString(),
                                              style: GoogleFonts.poppins(
                                                color: color,
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Gap(5),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 4,
                                              ),
                                              child: Text(
                                                "mg/dl",
                                                style: GoogleFonts.poppins(
                                                  color: Colors.grey.shade600,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          DateFormat(
                                            'MMM d, y, h:mm a',
                                          ).format(measurement.created_at),
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey.shade600,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    InkWell(
                                      onTap: () async {
                                        try {
                                          await db.deleteUserHealthData(
                                            measurement,
                                          );
                                          await ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Reading deleted successfully.',
                                              ),
                                              backgroundColor: Colors.green,
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                          // Future.delayed(
                                          //   Duration(seconds: 3),
                                          //   () => Navigator.pushReplacement(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //       builder:
                                          //           (c) => ReadingHistory(),
                                          //     ),
                                          //   ),
                                          // );
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (c) => ReadingHistory(),
                                            ),
                                          );
                                        } catch (e) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Failed to delete reading: $e',
                                              ),
                                              backgroundColor: Colors.red,
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                        }
                                      },
                                      child: Icon(
                                        Icons.cancel,
                                        color: Colors.red.shade700,
                                        size: 23,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
