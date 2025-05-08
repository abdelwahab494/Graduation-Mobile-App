import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/Tools/colors.dart';

information(String logo, String title, String measure) {
  return Column(
    children: [
      SvgPicture.asset(logo),
      Text(
        title,
        style: GoogleFonts.poppins(fontSize: 10, color: AppColors.primary),
      ),
      Text(
        measure,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
        ),
      ),
    ],
  );
}

reports(title, date) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300, width: 1),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      child: Row(
        children: [
          SvgPicture.asset("assets/icons/gen_report.svg"),
          Gap(15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                date,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          Spacer(),
          Icon(Icons.more_horiz_outlined),
        ],
      ),
    ),
  );
}

cards(title, logo) {
  return Card(
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          SvgPicture.asset(logo),
          Gap(15),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    ),
  );
}
