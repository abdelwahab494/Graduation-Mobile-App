import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/providers/collect_info_provider.dart';
import 'package:provider/provider.dart';

class AgeSection extends StatelessWidget {
  const AgeSection({super.key, required this.isLight});
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
            "What’s your approximate Age category?",
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
                "Select Age",
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
                  "18 : 24",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.text,
                  ),
                ),
                value: 1,
              ),
              DropdownMenuItem(
                child: Text(
                  "25 : 29",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.text,
                  ),
                ),
                value: 2,
              ),
              DropdownMenuItem(
                child: Text(
                  "30 : 34",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.text,
                  ),
                ),
                value: 3,
              ),
              DropdownMenuItem(
                child: Text(
                  "35 : 39",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.text,
                  ),
                ),
                value: 4,
              ),
              DropdownMenuItem(
                child: Text(
                  "40 : 44",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.text,
                  ),
                ),
                value: 5,
              ),
              DropdownMenuItem(
                child: Text(
                  "45 : 49",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.text,
                  ),
                ),
                value: 6,
              ),
              DropdownMenuItem(
                child: Text(
                  "50 : 54",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.text,
                  ),
                ),
                value: 7,
              ),
              DropdownMenuItem(
                child: Text(
                  "55 : 59",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.text,
                  ),
                ),
                value: 8,
              ),
              DropdownMenuItem(
                child: Text(
                  "60 : 64",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.text,
                  ),
                ),
                value: 9,
              ),
              DropdownMenuItem(
                child: Text(
                  "65 : 69",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.text,
                  ),
                ),
                value: 10,
              ),
              DropdownMenuItem(
                child: Text(
                  "70 : 74",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.text,
                  ),
                ),
                value: 11,
              ),
              DropdownMenuItem(
                child: Text(
                  "75 : 79",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.text,
                  ),
                ),
                value: 12,
              ),
              DropdownMenuItem(
                child: Text(
                  "80 or older",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.text,
                  ),
                ),
                value: 13,
              ),
            ],
            onChanged: (value) {
              provider.age = value!;
            },
          ),
        ),
      ],
    );
  }
}
