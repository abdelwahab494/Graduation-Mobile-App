import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/core/colors.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.title, required this.logo});
  final String title;
  final IconData logo;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.backGround,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xffe6eefb),
                borderRadius: BorderRadius.circular(500),
              ),
              child: Icon(logo, color: AppColors.primary),
            ),
            Gap(15),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}