import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/components/custom_app_bar.dart';
import 'package:grad_project/components/custom_botton.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/database/user_health_data/user_health_data.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DiabetesDetailes extends StatefulWidget {
  DiabetesDetailes({super.key, required this.report});
  final UserHealthData report;

  @override
  State<DiabetesDetailes> createState() => _DiabetesDetailesState();
}

class _DiabetesDetailesState extends State<DiabetesDetailes> {
  final Map data = {
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
    "Education": [
      "No school",
      "Grades 1-8",
      "Grades 9-11",
      "Grades 12",
      "no degree",
      "Bachelor's",
    ],
    "Income": [
      "< \$10,000",
      "\$10,000:\$14,999",
      "\$10,000 : \$14,999",
      "\$25,000 : \$34,999",
      "< \$35,000",
      "\$35,000 : \$49,999",
      "\$50,000 : \$74,999",
      "> \$75,000",
    ],
  };

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      appBar: CustomAppBar(title: "Report Detailes"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  widget.report.predictionStatus <= 25.0
                      ? "Not Diabetes    ${widget.report.predictionStatus}%"
                      : "Diabetes    ${widget.report.predictionStatus}%",
                  style: GoogleFonts.poppins(
                    color:
                        widget.report.predictionStatus <= 25.0
                            ? Colors.green.shade600
                            : Colors.red.shade600,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Gap(15),
              Skeletonizer(
                enabled: isLoading,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.3,
                  ),
                  itemCount: 12,
                  itemBuilder: (BuildContext context, int index) {
                    String title;
                    String value;
                    IconData icon = Icons.question_mark;
                    switch (index) {
                      case 0:
                        title = "Age";
                        value = data["Age"][widget.report.age.toInt() - 1];
                        icon = Icons.person_outline;
                        break;
                      case 1:
                        title = "BMI";
                        value = widget.report.bmi.toStringAsFixed(1);
                        icon = Icons.boy_outlined;
                        break;
                      case 2:
                        title = "High BP";
                        value =
                            widget.report.highbp.toInt() == 0 ? "No" : "Yes";
                        icon = Icons.monitor_heart_rounded;
                        break;
                      case 3:
                        title = "High Chol";
                        value =
                            widget.report.highcol.toInt() == 0 ? "No" : "Yes";
                        icon = Icons.water_drop_outlined;
                        break;
                      case 4:
                        title = "Stroke";
                        value =
                            widget.report.stroke.toInt() == 0 ? "No" : "Yes";
                        icon = Icons.psychology_alt_sharp;
                        break;
                      case 5:
                        title = "Heart Attack";
                        value =
                            widget.report.heartattack.toInt() == 0
                                ? "No"
                                : "Yes";
                        icon = Icons.heart_broken;
                        break;
                      case 6:
                        title = "Phys Activity";
                        value =
                            widget.report.physactivity.toInt() == 0
                                ? "No"
                                : "Yes";
                        icon = Icons.directions_bike;
                        break;
                      case 7:
                        title = "Gen Health";
                        value =
                            data["Gen Health"][widget.report.genhealth.toInt() -
                                1];
                        icon = Icons.content_paste_search;
                        break;
                      case 8:
                        title = "Phys Health";
                        value = "${widget.report.physhealth.toInt()} days";
                        icon = Icons.healing;
                        break;
                      case 9:
                        title = "Diff Walk";
                        value =
                            widget.report.diffwalk.toInt() == 0 ? "No" : "Yes";
                        icon = Icons.assist_walker;
                        break;
                      case 10:
                        title = "Education";
                        value =
                            data["Education"][widget.report.education.toInt() -
                                1];
                        icon = Icons.abc;
                        break;
                      case 11:
                        title = "Income";
                        value =
                            data["Income"][widget.report.income.toInt() - 1];
                        icon = Icons.wallet_outlined;
                        break;
                      default:
                        title = "Unknown";
                        value = "N/A";
                        icon = Icons.question_mark_outlined;
                    }

                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: const Color(0xffe6eefb),
                                borderRadius: BorderRadius.circular(500),
                              ),
                              child: Icon(
                                icon,
                                color: AppColors.primary,
                                size: 25,
                              ),
                            ),
                          ),
                          Text(
                            title,
                            style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          const Gap(5),
                          FittedBox(
                            child: Text(
                              value,
                              style: GoogleFonts.poppins(
                                color: AppColors.text,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Gap(30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 7),
        child: SafeArea(
          child: CustomBotton(
            onTap: () => Navigator.pop(context),
            text: "Back",
          ),
        ),
      ),
    );
  }
}
