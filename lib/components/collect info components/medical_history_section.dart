import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/components/customtextfield.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/providers/collect_info_provider.dart';
import 'package:provider/provider.dart';

class MedicalHistorySection extends StatelessWidget {
  const MedicalHistorySection({
    super.key,
    required this.isLight,
    required this.recentGLC, required this.formKey,
  });
  final isLight;
  final TextEditingController recentGLC;
  final GlobalKey formKey;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CollectInfoProvider>(context);

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "Recent Glucose Level (mg/gl)",
              style: GoogleFonts.poppins(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
          Gap(5),
          SizedBox(
            height: 50,
            child: OnlyNumTextField(
              controller: recentGLC,
              hint: "e.g. 120",
              icon: Icons.medical_information,
            ),
          ),
          Gap(10),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "Do you have history of High Blood Pressure?",
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
                    groupValue: provider.highBP,
                    onChanged: (value) {
                      provider.highBP = value!;
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
                    groupValue: provider.highBP,
                    onChanged: (value) {
                      provider.highBP = value!;
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
          Gap(10),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "Do you have High Cholesterol?",
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
                    groupValue: provider.highChol,
                    onChanged: (value) {
                      provider.highChol = value!;
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
                    groupValue: provider.highChol,
                    onChanged: (value) {
                      provider.highChol = value!;
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
          Gap(10),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "Have you ever had a Stroke?",
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
                    groupValue: provider.stroke,
                    onChanged: (value) {
                      provider.stroke = value!;
                      print(provider.stroke);
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
                    groupValue: provider.stroke,
                    onChanged: (value) {
                      provider.stroke = value!;
                      print(provider.stroke);
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
          Gap(10),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "Have you had a heart disease or attack?",
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
                    groupValue: provider.heartAttack,
                    onChanged: (value) {
                      provider.heartAttack = value!;
                      print(provider.heartAttack);
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
                    groupValue: provider.heartAttack,
                    onChanged: (value) {
                      provider.heartAttack = value!;
                      print(provider.heartAttack);
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
      ),
    );
  }
}
