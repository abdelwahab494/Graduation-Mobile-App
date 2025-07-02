import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/screens/issues/issues.dart';
import 'package:grad_project/screens/user%20info/collect_info.dart';

class HomeButtons extends StatelessWidget {
  const HomeButtons({super.key, required this.onNavigate});
  final dynamic onNavigate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (c) => CollectInfo()),
              ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(500),
                ),
                child: SvgPicture.asset(
                  "assets/icons/Top Doctors.svg",
                  width: 35,
                ),
              ),
              Gap(10),
              Text(
                "Health \ncondition",
                style: GoogleFonts.poppins(fontSize: 14, color: AppColors.text),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => onNavigate(2),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(500),
                ),
                child: SvgPicture.asset("assets/icons/Pharmacy.svg", width: 35),
              ),
              Gap(10),
              Text(
                "Medicine \nTracking",
                style: GoogleFonts.poppins(fontSize: 14, color: AppColors.text),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (c) => Issues()),
              ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(500),
                ),
                child: Icon(
                  CupertinoIcons.question_diamond,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              Gap(10),
              Text(
                "Common\nIssues",
                style: GoogleFonts.poppins(fontSize: 14, color: AppColors.text),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
