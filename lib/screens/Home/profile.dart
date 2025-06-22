import 'dart:io';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/components/custom_card.dart';
import 'package:grad_project/components/custom_information.dart';
import 'package:grad_project/screens/issues/issues.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/auth/auth_service.dart';
import 'package:grad_project/providers/profile_image_provider.dart';
import 'package:grad_project/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // get auth service
  final authService = AuthService();
  void logout() async {
    await authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileImageProvider>(context, listen: false).loadImage();
    });

    return Consumer<ChangeThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          backgroundColor: AppColors.backGround,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Gap(60),
                  Consumer<ProfileImageProvider>(
                    builder: (context, imageProvider, child) {
                      return Stack(
                        children: [
                          AvatarGlow(
                            glowRadiusFactor: 0.3,
                            glowColor: AppColors.primary,
                            duration: Duration(milliseconds: 2000),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: AppColors.backGround,
                              backgroundImage:
                                  imageProvider.selectedImage == null
                                      ? AssetImage("assets/images/user.png")
                                      : FileImage(
                                        File(imageProvider.selectedImage!.path),
                                      ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: imageProvider.uploadImage,
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(500),
                                ),
                                child: Icon(
                                  Icons.edit,
                                  color: AppColors.backGround,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  Gap(8),
                  Text(
                    maxLines: 1,
                    authService.getCurrentItem("name"),
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gap(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomInformation(
                          logo: "assets/icons/Heartbeat.svg",
                          title: "Heart rate",
                          measure: "215bmp",
                        ),
                        CustomInformation(
                          logo: "assets/icons/Fire.svg",
                          title: "Calories",
                          measure: "756cal",
                        ),
                        CustomInformation(
                          logo: "assets/icons/weight.svg",
                          title: "Weight",
                          measure: "68kg",
                        ),
                      ],
                    ),
                  ),
                  Gap(15),
                  Column(
                    children: [
                      CustomCard(
                        title: "My Saved",
                        logo: CupertinoIcons.square_favorites_alt,
                      ),
                      Gap(5),
                      CustomCard(
                        title: "Appointment",
                        logo: CupertinoIcons.calendar_today,
                      ),
                      Gap(5),
                      CustomCard(
                        title: 'Payment Method',
                        logo: CupertinoIcons.money_dollar,
                      ),
                      Gap(5),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (c) => Issues()),
                          );
                        },
                        child: CustomCard(
                          title: "Common Issues",
                          logo: CupertinoIcons.question_diamond,
                        ),
                      ),
                      Gap(5),
                      Card(
                        color: AppColors.backGround,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Color(0xffe6eefb),
                                  borderRadius: BorderRadius.circular(500),
                                ),
                                child: Icon(
                                  CupertinoIcons.moon,
                                  color: AppColors.primary,
                                ),
                              ),
                              Gap(15),
                              Text(
                                "Dark Mode",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Switch(
                                activeColor: AppColors.primary,
                                value: !themeProvider.isLight,
                                onChanged: (value) {
                                  themeProvider.changeTheme();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Gap(5),
                      GestureDetector(
                        onTap: () => logout(),
                        child: CustomCard(
                          title: "Logout",
                          logo: Icons.logout_rounded,
                        ),
                      ),
                      Gap(10),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
