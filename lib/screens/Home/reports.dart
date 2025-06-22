import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/components/chat_botton.dart';
import 'package:grad_project/components/custom_report.dart';

class Reports extends StatelessWidget {
  const Reports({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Gap(60),
            Column(
              children: [
                SvgPicture.asset("assets/images/top.svg"),
                Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/images/bottomleft.svg"),
                    Gap(20),
                    SvgPicture.asset("assets/images/bottomright.svg"),
                  ],
                ),
                Gap(40),
              ],
            ),
            Row(
              children: [
                Text(
                  "Latest reports",
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
