import 'dart:io';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/screens/issues.dart';
import 'package:grad_project/Tools/colors.dart';
import 'package:grad_project/Tools/functions.dart';
import 'package:grad_project/Auth/auth_service.dart';
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
                        information(
                          "assets/icons/Heartbeat.svg",
                          "Heart rate",
                          "215bmp",
                        ),
                        information(
                          "assets/icons/Fire.svg",
                          "Calories",
                          "756cal",
                        ),
                        information(
                          "assets/icons/weight.svg",
                          "Weight",
                          "68kg",
                        ),
                      ],
                    ),
                  ),
                  Gap(15),
                  Column(
                    children: [
                      cards("My Saved", CupertinoIcons.square_favorites_alt),
                      Gap(5),
                      cards("Appointment", CupertinoIcons.calendar_today),
                      Gap(5),
                      cards("Payment Method", CupertinoIcons.money_dollar),
                      Gap(5),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (c) => Issues()),
                          );
                        },
                        child: cards(
                          "Common Issues",
                          CupertinoIcons.question_diamond,
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
                        child: cards("Logout", Icons.logout_rounded),
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
