import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/components/chat_botton.dart';
import 'package:grad_project/components/custom_report.dart';
import 'package:grad_project/screens/add_medicine.dart';
import 'package:grad_project/core/colors.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Gap(50),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    color: AppColors.backGround,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            "assets/images/food.svg",
                            width: 120,
                          ),
                          Gap(15),
                          Text(
                            "Food Tracking",
                            style: GoogleFonts.poppins(
                              color: AppColors.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (c) => AddMedicine()),
                        ),
                    child: Card(
                      color: AppColors.backGround,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              "assets/images/doctors.svg",
                              width: 120,
                            ),
                            Gap(15),
                            Text(
                              "Medicine Tracking",
                              style: GoogleFonts.poppins(
                                color: AppColors.primary,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gap(20),
            Row(
              children: [
                Text(
                  "Latest notifications",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.left,
                ),
                Spacer(),
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
            Expanded(
              child: ListView(
                children: [
                  CustomReport(title: "General Report 1", date: "Apr 9, 2002"),
                  Gap(10),
                  CustomReport(title: "General Report 2", date: "Feb 18, 2019"),
                  Gap(10),
                  CustomReport(title: "General Report 3", date: "Aug 6, 2023"),
                  Gap(10),
                  CustomReport(title: "General Report 4", date: "Aug 6, 2023"),
                  Gap(10),
                  CustomReport(title: "General Report 5", date: "Aug 6, 2023"),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ChatBotton(),
    );
  }
}
