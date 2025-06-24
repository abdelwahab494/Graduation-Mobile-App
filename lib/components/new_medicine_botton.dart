import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/core/colors.dart';

class NewMedicineBotton extends StatelessWidget {
  const NewMedicineBotton({super.key, required this.showBottomSheet});
  final showBottomSheet;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        color: AppColors.backGround,
        border: Border.all(color: AppColors.primary, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          showBottomSheet();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add, color: AppColors.primary, size: 24),
              Gap(8),
              Text(
                'Add New Medicine',
                style: GoogleFonts.poppins(
                  color: AppColors.primary,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
