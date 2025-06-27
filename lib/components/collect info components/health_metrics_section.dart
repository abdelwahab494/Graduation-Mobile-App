import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/components/customtextfield.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/providers/collect_info_provider.dart';
import 'package:provider/provider.dart';

class HealthMetricsSection extends StatelessWidget {
  HealthMetricsSection({
    super.key,
    required this.isLight,
    required this.heightC,
    required this.weightC,
    required this.physHealthC,
    required this.formKey,
  });
  final bool isLight;
  final TextEditingController heightC;
  final TextEditingController weightC;
  final TextEditingController physHealthC;
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
              "What is your Height? (in cm)",
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
              controller: heightC,
              hint: "e.g. 175",
              icon: Icons.height,
              minValue: 0,
            ),
          ),
          Gap(10),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "What is your Weight? (in kg)",
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
              controller: weightC,
              hint: "e.g. 70",
              icon: Icons.balance,
              minValue: 0,
            ),
          ),
          Gap(10),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "How would you rate your general health?",
              style: GoogleFonts.poppins(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
          Gap(5),
          SizedBox(
            height: 55,
            child: DropdownButtonFormField(
              dropdownColor: AppColors.backGround,
              decoration: InputDecoration(
                label: Text(
                  "General Health rate",
                  style: GoogleFonts.poppins(fontSize: 13),
                ),
                labelStyle: TextStyle(
                  color:
                      isLight
                          ? Color.fromARGB(255, 73, 73, 73)
                          : Color(0xffF2F2F2),
                  fontSize: 14,
                ),
                filled: true,
                fillColor:
                    isLight
                        ? Color(0xffF2F2F2)
                        : Color.fromARGB(255, 73, 73, 73),
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.black),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.primary, width: 2.0),
                ),
              ),
              items: [
                DropdownMenuItem(
                  child: Text(
                    "Excellent",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: AppColors.text,
                    ),
                  ),
                  value: 1,
                ),
                DropdownMenuItem(
                  child: Text(
                    "Very good",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: AppColors.text,
                    ),
                  ),
                  value: 2,
                ),
                DropdownMenuItem(
                  child: Text(
                    "Good",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: AppColors.text,
                    ),
                  ),
                  value: 3,
                ),
                DropdownMenuItem(
                  child: Text(
                    "Fair",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: AppColors.text,
                    ),
                  ),
                  value: 4,
                ),
                DropdownMenuItem(
                  child: Text(
                    "Poor",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: AppColors.text,
                    ),
                  ),
                  value: 5,
                ),
              ],
              onChanged: (value) {
                provider.genHealth = value!;
              },
            ),
          ),
          Gap(10),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "How many days in the past 30 days was your physical health not good?",
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
              controller: physHealthC,
              hint: "e.g. 1-30 days",
              icon: Icons.calendar_month,
              minValue: 0,
              maxValue: 30,
            ),
          ),
          Gap(10),
        ],
      ),
    );
  }
}
