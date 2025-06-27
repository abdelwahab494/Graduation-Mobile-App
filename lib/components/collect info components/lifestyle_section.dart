import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/providers/collect_info_provider.dart';
import 'package:provider/provider.dart';

class LifestyleSection extends StatelessWidget {
  const LifestyleSection({super.key, required this.isLight});
  final bool isLight;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CollectInfoProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            "Have you been physically active in the past 30 days?",
            style: GoogleFonts.poppins(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
        Column(
          children: [
            Row(
              children: [
                Radio(
                  value: 1,
                  groupValue: provider.physActivity,
                  onChanged: (value) {
                    provider.physActivity = value!;
                  },
                  activeColor: AppColors.primary,
                ),
                Text(
                  "Yes, >3 times/week",
                  style: GoogleFonts.poppins(
                    color: AppColors.text,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: 0,
                  groupValue: provider.physActivity,
                  onChanged: (value) {
                    provider.physActivity = value!;
                  },
                  activeColor: AppColors.primary,
                ),
                Text(
                  "Rarely/Never",
                  style: GoogleFonts.poppins(
                    color: AppColors.text,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
        Gap(10),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            "Do you have serious difficulty walking or climbing stairs?",
            style: GoogleFonts.poppins(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
        Column(
          children: [
            Row(
              children: [
                Radio(
                  value: 1,
                  groupValue: provider.diffWalk,
                  onChanged: (value) {
                    provider.diffWalk = value!;
                  },
                  activeColor: AppColors.primary,
                ),
                Text(
                  "Yes",
                  style: GoogleFonts.poppins(
                    color: AppColors.text,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: 0,
                  groupValue: provider.diffWalk,
                  onChanged: (value) {
                    provider.diffWalk = value!;
                  },
                  activeColor: AppColors.primary,
                ),
                Text(
                  "No",
                  style: GoogleFonts.poppins(
                    color: AppColors.text,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
