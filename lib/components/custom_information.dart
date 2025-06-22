import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/core/colors.dart';

class CustomInformation extends StatelessWidget {
  const CustomInformation({super.key, required this.logo, required this.title, required this.measure});
  final String logo, title, measure;

  @override
  Widget build(BuildContext context) {
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
}
