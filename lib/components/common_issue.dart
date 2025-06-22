import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/core/colors.dart';

class CommonIssue extends StatelessWidget {
  const CommonIssue({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onTap,
  });
  final String title, subTitle;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.backGround,
            border: Border.all(color: Colors.grey.shade300, width: 1.5),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ListTile(
            title: Text(
              title,
              maxLines: 1,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            subtitle: Text(
              textAlign: TextAlign.right,
              subTitle,
              maxLines: 1,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: AppColors.text,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
          ),
        ),
      ),
    );
  }
}
