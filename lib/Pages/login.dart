import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/Pages/Home/base.dart';
import 'package:grad_project/Pages/signup.dart';
import 'package:grad_project/Tools/colors.dart';
import 'package:grad_project/Tools/customtextfield.dart';

class Login extends StatelessWidget {
  const Login({super.key});

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
          "Login",
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
              hint: "Enter your email",
              icon: Icons.mail_outline_outlined,
            ),
            SizedBox(height: 20),
            CustomTextField(
              controller: password,
              hint: "Enter your password",
              icon: Icons.lock_outlined,
            ),
            Gap(10),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  "Forgot Password?",
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
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
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don’t have an account?",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Signup()),
                    );
                  },
                  child: Text(
                    " Sign Up",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            Gap(100),
            SvgPicture.asset("assets/icons/hr.svg"),
            Gap(30),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    Gap(10),
                    SvgPicture.asset("assets/icons/Google.svg"),
                    Gap(30),
                    Text(
                      "Sign in with Google",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gap(20),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    Gap(10),
                    SvgPicture.asset("assets/icons/Facebook.svg"),
                    Gap(30),
                    Text(
                      "Sign in with Facebook",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
