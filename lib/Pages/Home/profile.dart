import 'dart:io';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/Pages/issues.dart';
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

    return Scaffold(
      backgroundColor: Colors.white,
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
                          backgroundColor: Colors.white,
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
                            child: Icon(Icons.edit, color: Colors.white),
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
                    information("assets/icons/Fire.svg", "Calories", "756cal"),
                    information("assets/icons/weight.svg", "Weight", "68kg"),
                  ],
                ),
              ),
              Gap(15),
              Column(
                children: [
                  cards("My Saved", "assets/icons/heart.svg"),
                  Gap(5),
                  cards("Appointment", "assets/icons/calender.svg"),
                  Gap(5),
                  cards("Payment Method", "assets/icons/wallet.svg"),
                  Gap(5),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (c) => Issues()),
                      );
                    },
                    child: cards("Common Issues", "assets/icons/message.svg"),
                  ),
                  Gap(5),
                  Card(
                    color: Colors.white,
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
                            value:
                                !Provider.of<ChangeThemeProvider>(
                                  context,
                                  listen: false,
                                ).isLight,
                            onChanged:
                                (value) =>
                                    Provider.of<ChangeThemeProvider>(
                                      context,
                                      listen: false,
                                    ).changeTheme(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(5),
                  GestureDetector(
                    onTap: () => logout(),
                    child: cards("Logout", "assets/icons/logout.svg"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
