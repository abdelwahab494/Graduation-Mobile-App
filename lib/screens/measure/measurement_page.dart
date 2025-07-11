import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/components/custom_app_bar.dart';
import 'package:grad_project/components/custom_botton.dart';
import 'package:grad_project/components/feedback.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/database/glucose_measurements/glucose_measurements.dart';
import 'package:grad_project/database/glucose_measurements/glucose_measurements_database.dart';
import 'package:grad_project/providers/measure_provider.dart';
import 'package:grad_project/screens/measure/glucose_line_chart.dart';
import 'package:grad_project/screens/measure/loading_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MeasurementPage extends StatefulWidget {
  MeasurementPage({super.key});

  @override
  State<MeasurementPage> createState() => _MeasurementPageState();
}

class _MeasurementPageState extends State<MeasurementPage> {
  bool saved = false;
  bool showFeedback = true;
  final TextEditingController feedbackController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<MeasureProvider>(
      context,
      listen: false,
    ).updateRatingAndColors();
    saved = false;
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDateTime =
        DateFormat('EEEE,  hh:mm a').format(now).toString();
    final width = MediaQuery.of(context).size.width;

    return Consumer<MeasureProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: AppColors.backGround,
          appBar: CustomAppBar(title: ""),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                provider.icon,
                                color: provider.color,
                                size: 18,
                              ),
                              Gap(10),
                              Text(
                                provider.rating.toString(),
                                style: GoogleFonts.poppins(
                                  color: provider.color,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(10),
                      ],
                    ),
                  ),
                  Gap(20),
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
                          width: width * 0.4,
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
                        onTap: () async {
                          if (provider.glucose != 0 && saved == false) {
                            await provider.saveMeasurementToDatabase();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.green,
                                content: Text(
                                  "Reading Saved Successfully!",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                            setState(() {
                              saved = true;
                            });
                          } else {
                            null;
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          width: width * 0.4,
                          decoration: BoxDecoration(
                            color:
                                provider.glucose == 0
                                    ? Colors.grey
                                    : (saved ? Colors.grey : AppColors.primary),
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color:
                                  provider.glucose == 0
                                      ? Colors.grey
                                      : (saved
                                          ? Colors.grey
                                          : AppColors.primary),
                              width: 2,
                            ),
                          ),
                          child: Text(
                            saved ? "Saved" : "Save",
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
                  Gap(30),
                  saved
                      ? (showFeedback
                          ? Column(
                            children: [
                              FeedbackContainer(
                                onTap: () {
                                  provider.submitFeedback(
                                    feedbackController.text,
                                  );

                                  if (provider.feedbackResult.contains(
                                    "Error",
                                  )) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Error Submitting Feedback!\nPlease try again.",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                    return;
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          provider.feedbackResult,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                    return;
                                  }
                                },
                                controller: feedbackController,
                                provider: provider,
                                onTap2: () {
                                  setState(() => showFeedback = false);
                                  feedbackController.clear();
                                },
                                cancel: true,
                              ),
                              Gap(25),
                            ],
                          )
                          : SizedBox.shrink())
                      : SizedBox.shrink(),
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
                                Icons.trending_up_outlined,
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
                              return GlucoseLineChart(
                                measurements: measurements,
                              );
                            },
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

// class WavePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint =
//         Paint()
//           ..color = Colors.blue
//           ..style = PaintingStyle.fill;

//     final path = Path();
//     path.moveTo(0, size.height * 0.5);
//     path.quadraticBezierTo(
//       size.width * 0.25,
//       size.height * 0.7,
//       size.width * 0.5,
//       size.height * 0.6,
//     ); // Higher curve
//     path.quadraticBezierTo(
//       size.width * 0.75,
//       size.height * 0.5,
//       size.width,
//       size.height * 0.6,
//     ); // Higher curve
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//     path.close();

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
