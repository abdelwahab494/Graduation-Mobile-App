import 'package:flutter/material.dart';
import 'package:grad_project/auth/auth_service.dart';
import 'package:grad_project/components/custom_app_bar.dart';
import 'package:grad_project/components/custom_report.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/database/user_health_data/user_health_data.dart';
import 'package:grad_project/database/user_health_data/user_health_database.dart';
import 'package:grad_project/screens/user%20info/collect_info.dart';
import 'package:grad_project/screens/user%20info/diabetes_detailes.dart';

class AllDiabetesHistory extends StatefulWidget {
  const AllDiabetesHistory({super.key});

  @override
  State<AllDiabetesHistory> createState() => _AllDiabetesHistoryState();
}

class _AllDiabetesHistoryState extends State<AllDiabetesHistory> {
  final _streamKey = GlobalKey();
  final bool isPartner = AuthService().getCurrentItemBool("isPartner");

  @override
  Widget build(BuildContext context) {
    final db = UserHealthDatabase();
    return Scaffold(
      backgroundColor: AppColors.backGround,
      appBar: CustomAppBar(title: "Diabetes History"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        child: StreamBuilder<List<UserHealthData>>(
          key: _streamKey,
          stream: db.stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                backgroundColor: AppColors.backGround,
                body: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                ),
              );
            }
            if (snapshot.hasError) {
              return Scaffold(
                backgroundColor: AppColors.backGround,
                body: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Center(
                    child: Text(
                      'Something went wrong!\n please check your connection.',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Scaffold(
                backgroundColor: AppColors.backGround,
                body: GestureDetector(
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (c) => CollectInfo()),
                      ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
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
                ),
              );
            }
            final reports = snapshot.data!;
            return Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: reports.length,
                  itemBuilder: (BuildContext context, int index) {
                    final report = reports[index];
                    return GestureDetector(
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (c) => DiabetesDetailes(report: report),
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
      ),
    );
  }
}
