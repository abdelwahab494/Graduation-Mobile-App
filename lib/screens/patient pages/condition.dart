import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/auth/auth_service.dart';
import 'package:grad_project/components/custom_report.dart';
import 'package:grad_project/components/start_quize.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/database/user_health_data/user_health_data.dart';
import 'package:grad_project/database/user_health_data/user_health_database.dart';
import 'package:grad_project/screens/user%20info/all_diabetes_history.dart';
import 'package:grad_project/screens/user%20info/collect_info.dart';
import 'package:grad_project/screens/user%20info/diabetes_detailes.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Condition extends StatefulWidget {
  Condition({super.key});

  @override
  State<Condition> createState() => _ConditionState();
}

class _ConditionState extends State<Condition> {
  UserHealthData? latestData;
  bool isLoading = false;
  final _streamKey = GlobalKey();
  final bool isPartner = AuthService().getCurrentItemBool("isPartner");

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

  @override
  void initState() {
    super.initState();
    _fetchLatestData();
  }

  Future<void> _fetchLatestData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final data = await UserHealthDatabase().getLatestUserHealthData();
      setState(() {
        latestData = data;
      });
    } catch (e) {
      print('Error fetching latest data: $e');
      setState(() {
        latestData = null;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final db = UserHealthDatabase();
    return Scaffold(
      backgroundColor: AppColors.backGround,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Gap(25),
              StartQuize(),
              Gap(20),
              latestData == null
                  ? SizedBox.shrink()
                  : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            !isPartner
                                ? "Patient Overview"
                                : "Your Patient's Overview",
                            style: GoogleFonts.poppins(
                              color: AppColors.text,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          IconButton(
                            onPressed: () => _fetchLatestData(),
                            icon: Icon(Icons.refresh, color: AppColors.primary),
                            tooltip: "Refresh",
                          ),
                        ],
                      ),
                      const Gap(10),
                      Skeletonizer(
                        enabled: isLoading,
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(0),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 0.95,
                              ),
                          itemCount: 12,
                          itemBuilder: (BuildContext context, int index) {
                            String title;
                            String value;
                            IconData icon = Icons.question_mark;
                            if (latestData == null) {
                              title = "Placeho";
                              value = "100";
                            } else {
                              switch (index) {
                                case 0:
                                  title = "Age";
                                  value =
                                      data["Age"][latestData!.age.toInt() - 1];
                                  icon = Icons.person_outline;
                                  break;
                                case 1:
                                  title = "BMI";
                                  value = latestData!.bmi.toStringAsFixed(1);
                                  icon = Icons.boy_outlined;
                                  break;
                                case 2:
                                  title = "High BP";
                                  value =
                                      latestData!.highbp.toInt() == 0
                                          ? "No"
                                          : "Yes";
                                  icon = Icons.monitor_heart_rounded;
                                  break;
                                case 3:
                                  title = "High Chol";
                                  value =
                                      latestData!.highcol.toInt() == 0
                                          ? "No"
                                          : "Yes";
                                  icon = Icons.water_drop_outlined;
                                  break;
                                case 4:
                                  title = "Stroke";
                                  value =
                                      latestData!.stroke.toInt() == 0
                                          ? "No"
                                          : "Yes";
                                  icon = Icons.psychology_alt_sharp;
                                  break;
                                case 5:
                                  title = "Heart Attack";
                                  value =
                                      latestData!.heartattack.toInt() == 0
                                          ? "No"
                                          : "Yes";
                                  icon = Icons.heart_broken;
                                  break;
                                case 6:
                                  title = "Phys Activity";
                                  value =
                                      latestData!.physactivity.toInt() == 0
                                          ? "No"
                                          : "Yes";
                                  icon = Icons.directions_bike;
                                  break;
                                case 7:
                                  title = "Gen Health";
                                  value =
                                      data["Gen Health"][latestData!.genhealth
                                              .toInt() -
                                          1];
                                  icon = Icons.content_paste_search;
                                  break;
                                case 8:
                                  title = "Phys Health";
                                  value =
                                      "${latestData!.physhealth.toInt()} days";
                                  icon = Icons.healing;
                                  break;
                                case 9:
                                  title = "Diff Walk";
                                  value =
                                      latestData!.diffwalk.toInt() == 0
                                          ? "No"
                                          : "Yes";
                                  icon = Icons.assist_walker;
                                  break;
                                case 10:
                                  title = "Education";
                                  value =
                                      data["Education"][latestData!.education
                                              .toInt() -
                                          1];
                                  icon = Icons.abc;
                                  break;
                                case 11:
                                  title = "Income";
                                  value =
                                      data["Income"][latestData!.income
                                              .toInt() -
                                          1];
                                  icon = Icons.wallet_outlined;
                                  break;
                                default:
                                  title = "Unknown";
                                  value = "N/A";
                                  icon = Icons.question_mark_outlined;
                              }
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffe6eefb),
                                        borderRadius: BorderRadius.circular(
                                          500,
                                        ),
                                      ),
                                      child: Icon(
                                        icon,
                                        color: AppColors.primary,
                                        size: 18,
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
                      GestureDetector(
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (c) => AllDiabetesHistory(),
                              ),
                            ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              !isPartner
                                  ? "Patient Diabetes History"
                                  : "Your Patient's Diabetes History",
                              style: GoogleFonts.poppins(
                                color: AppColors.text,
                                fontSize: !isPartner ? 18 : 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "See all",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      StreamBuilder<List<UserHealthData>>(
                        key: _streamKey,
                        stream: db.stream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                            return GestureDetector(
                              onTap:
                                  () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (c) => CollectInfo(),
                                    ),
                                  ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 30,
                                ),
                                child: Center(
                                  child: Text(
                                    !isPartner
                                        ? "No History yet.\nStart Assessment!"
                                        : 'Your patient has no History yet.\nStart Assessment!',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.text,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          final reports = snapshot.data!;
                          return Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:
                                    reports.length <= 4 ? reports.length : 5,
                                itemBuilder: (BuildContext context, int index) {
                                  final report = reports[index];
                                  return GestureDetector(
                                    onTap:
                                        () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (c) => DiabetesDetailes(
                                                  report: report,
                                                ),
                                          ),
                                        ),
                                    child: CustomReport(
                                      title:
                                          report.predictionStatus == 0
                                              ? "Not Diabetes"
                                              : "Diabetes",
                                      date: report.createdAt.toString(),
                                      color:
                                          report.predictionStatus == 0
                                              ? Colors.green.shade600
                                              : Colors.red.shade600,
                                      picColor:
                                          report.predictionStatus == 0
                                              ? Colors.green.shade600
                                              : Colors.red.shade600,
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      Gap(30),
                    ],
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
