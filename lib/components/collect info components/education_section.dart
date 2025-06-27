import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/providers/collect_info_provider.dart';
import 'package:provider/provider.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({
    super.key,
    required this.isLight,
  });
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
            "What’s your Education level?",
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
                "Select your Education",
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
                  isLight ? Color(0xffF2F2F2) : Color.fromARGB(255, 73, 73, 73),
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
                  "No school or only kindergarten",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.text,
                  ),
                ),
                value: 1,
              ),
              DropdownMenuItem(
                child: Text(
                  "Grades 1-8 (elementary/middle school)",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.text,
                  ),
                ),
                value: 2,
              ),
              DropdownMenuItem(
                child: Text(
                  "Grades 9-11 (some high school)",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.text,
                  ),
                ),
                value: 3,
              ),
              DropdownMenuItem(
                child: Text(
                  "Grades 12 or GED (high school graduate)",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.text,
                  ),
                ),
                value: 4,
              ),
              DropdownMenuItem(
                child: Text(
                  "Some college school (no degree yet)",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.text,
                  ),
                ),
                value: 5,
              ),
              DropdownMenuItem(
                child: Text(
                  "Bachelor's degree or higher",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.text,
                  ),
                ),
                value: 6,
              ),
            ],
            onChanged: (value) {
              provider.education = value!;
            },
          ),
        ),
      ],
    );
  }
}
