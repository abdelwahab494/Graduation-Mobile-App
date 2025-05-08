import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/Pages/info.dart';
import 'package:grad_project/Tools/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => Info()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe4ecf7),
      body: Center(
        child: Stack(
          children: [
            Positioned(
              child: Image.asset("assets/icons/background.png", fit: BoxFit.cover,),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/icons/logo.png"),
                  Gap(20),
                  Text(
                    "Healthcare",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 32,
                      color: AppColors.logo,
                    ),
                  ),
                  Text(
                    "Medical app",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColors.logo,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
