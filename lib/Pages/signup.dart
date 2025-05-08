import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/Pages/Home/base.dart';
import 'package:grad_project/Pages/login.dart';
import 'package:grad_project/Tools/colors.dart';
import 'package:grad_project/Tools/customtextfield.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Sign Up",
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: Column(
          children: [
            Gap(30),
            CustomTextField(
              controller: username,
              hint: "Enter your name",
              icon: Icons.person_outline_outlined,
            ),
            Gap(20),
            CustomTextField(
              controller: password,
              hint: "Enter your email",
              icon: Icons.mail_outline_outlined,
            ),
            Gap(20),
            CustomTextField(
              controller: password,
              hint: "Enter your password",
              icon: Icons.lock_outlined,
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (c) => Base()),
                );
              },
              child: Container(
                padding: EdgeInsets.all(15),
                width: 350,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  "Create account",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: Text(
                    " Login",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            Gap(50),
          ],
        ),
      ),
    );
  }
}
