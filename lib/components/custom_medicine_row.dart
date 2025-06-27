import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/core/colors.dart';

class CustomMedicineRow extends StatelessWidget {
  const CustomMedicineRow({
    super.key,
    required this.icon,
    required this.title,
    required this.data,
    required this.type,
  });
  final icon;
  final String title;
  final String data;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        type == "SVG"
            ? SvgPicture.asset(icon, color: AppColors.primary, width: 20)
            : type == "PNG"
            ? Image.asset(icon, color: AppColors.primary, width: 18)
            : type == "icon"
            ? Icon(icon, color: AppColors.primary, size: 20)
            : SizedBox.shrink(),
        Gap(10),
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.poppins(color: Colors.grey, fontSize: 13),
        ),
        Gap(5),
        Text(
          data,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.poppins(color: AppColors.text, fontSize: 16),
        ),
      ],
    );
  }
}
