import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/providers/profile_image_provider.dart';
import 'package:provider/provider.dart';

class WelcomeUser extends StatelessWidget {
  const WelcomeUser({
    super.key,
    required this.onNavigate,
    required this.currentusername,
    this.isPartner = false,
  });
  final dynamic onNavigate;
  final String currentusername;
  final bool isPartner;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Consumer<ProfileImageProvider>(
            builder: (context, imageProvider, child) {
              return GestureDetector(
                onTap: () => onNavigate(3),
                child: AvatarGlow(
                  glowRadiusFactor: 0.25,
                  glowColor: AppColors.primary,
                  duration: Duration(milliseconds: 2000),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    backgroundImage:
                        imageProvider.selectedImage == null
                            ? AssetImage("assets/images/user.png")
                            : FileImage(
                              File(imageProvider.selectedImage!.path),
                            ),
                  ),
                ),
              );
            },
          ),
          Gap(15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome !",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                currentusername,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
              ),
              Gap(5),
              Text(
                "How is it going today ?",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
          Spacer(),
          !isPartner
              ? GestureDetector(
                onTap: () {
                  onNavigate(2);
                },
                child: Icon(Icons.notifications, color: AppColors.primary),
              )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
