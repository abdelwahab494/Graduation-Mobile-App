import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/providers/collect_info_provider.dart';
import 'package:provider/provider.dart';

class IncomeSection extends StatelessWidget {
  const IncomeSection({super.key, required this.isLight});
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
            "What’s your Income range?",
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
                "Select Income",
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
                  "Less than \$10,000",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.text,
                  ),
                ),
                value: 1,
              ),
              DropdownMenuItem(
                child: Text(
                  "\$10,000 to \$14,999",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.text,
                  ),
                ),
                value: 2,
              ),
              DropdownMenuItem(
                child: Text(
                  "\$15,000 to \$24,999",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.text,
                  ),
                ),
                value: 3,
              ),
              DropdownMenuItem(
                child: Text(
                  "\$25,000 to \$34,999",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.text,
                  ),
                ),
                value: 4,
              ),
              DropdownMenuItem(
                child: Text(
                  "Less than \$35,000",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.text,
                  ),
                ),
                value: 5,
              ),
              DropdownMenuItem(
                child: Text(
                  "\$35,000 to \$49,999",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.text,
                  ),
                ),
                value: 6,
              ),
              DropdownMenuItem(
                child: Text(
                  "\$50,000 to \$74,999",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.text,
                  ),
                ),
                value: 7,
              ),
              DropdownMenuItem(
                child: Text(
                  "\$75,000 or more",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.text,
                  ),
                ),
                value: 8,
              ),
            ],
            onChanged: (value) {
              provider.income = value!;
            },
          ),
        ),
      ],
    );
  }
}
