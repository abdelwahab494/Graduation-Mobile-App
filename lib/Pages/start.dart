import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/Pages/login.dart';
import 'package:grad_project/Pages/signup.dart';
import 'package:grad_project/Tools/colors.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icons/logo.png", width: 118),
            Gap(20),
            Text(
              "Healthcare",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 25,
                color: AppColors.logo,
              ),
            ),
            Gap(20),
            Text(
              "Let’s get started!",
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Login to Stay healthy and fit ",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.grey.shade600,
              ),
            ),
            Gap(40),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (c) => Login()),
                );
              },
              child: Container(
                padding: EdgeInsets.all(15),
                width: 250,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  "Login",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Gap(15),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (c) => Signup()),
                );
              },
              child: Container(
                padding: EdgeInsets.all(15),
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: AppColors.primary, width: 2),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  "Sign Up",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
