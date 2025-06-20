import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/providers/signup_provider.dart';
import 'package:grad_project/screens/login.dart';
import 'package:grad_project/Tools/colors.dart';
import 'package:grad_project/components/customtextfield.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  // // checkbox value
  // bool _isTermsAccepted = false;

  // // get auth service
  // final authService = AuthService();

  // // text controllers
  // final _usernamecontroller = TextEditingController();
  // final _emailController = TextEditingController();
  // final _passwordController = TextEditingController();
  // final _confirmPasswordController = TextEditingController();

  // sign up button pressed

  // @override
  // void dispose() {
  //   _emailController.dispose();
  //   _passwordController.dispose();
  //   _confirmPasswordController.dispose();
  //   _usernamecontroller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignupProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: AppColors.backGround,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Gap(30),
                              CustomTextField(
                                controller: provider.usernamecontroller,
                                hint: "Name",
                                icon: Icons.person_outline_outlined,
                              ),
                              Gap(20),
                              OnlyEmailTextField(
                                controller: provider.emailController,
                                hint: "Email",
                                icon: Icons.mail_outline_outlined,
                              ),
                              Gap(20),
                              PasswordTextField(
                                controller: provider.passwordController,
                                hint: "Password",
                                icon: Icons.lock_outlined,
                              ),
                              Gap(20),
                              PasswordTextField(
                                controller: provider.confirmPasswordController,
                                hint: "Confirm password",
                                icon: Icons.lock_outlined,
                              ),
                              Gap(20),
                              CheckboxListTile(
                                checkColor: Colors.white,
                                activeColor: AppColors.primary,
                                contentPadding: EdgeInsets.zero,
                                value: provider.isTermsAccepted,
                                onChanged: (newValue) {
                                  // setState(() {
                                  //   _isTermsAccepted = newValue!;
                                  // });
                                  provider.toggleCheck(newValue);
                                },
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "I agree to the ",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.text,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => _showDialog(context),
                                      child: Text(
                                        "Privacy & Security Policy.",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 36,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      // GestureDetector(
                      //   onTap: () => {},
                      //   child: Container(
                      //     padding: EdgeInsets.all(15),
                      //     width: 350,
                      //     decoration: BoxDecoration(
                      //       color:
                      //           provider.isTersAccepted
                      //               ? AppColors.primary
                      //               : Colors.grey,
                      //       borderRadius: BorderRadius.circular(50),
                      //     ),
                      //     child: Text(
                      //       "Create account",
                      //       textAlign: TextAlign.center,
                      //       style: GoogleFonts.inter(
                      //         fontSize: 16,
                      //         fontWeight: FontWeight.w600,
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.text,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Future _showDialog(context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(15),
        backgroundColor: Colors.white,
        title: Text(
          "Privacy & Security Policy.",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            color: AppColors.primary,
          ),
        ),
        actions: [
          Center(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.all(12),
                width: 150,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  "Back",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
        content: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 247, 250, 255),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primary),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "We care about your privacy. We request your consent to:",
                  style: GoogleFonts.poppins(
                    color: AppColors.logo,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "• ",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.text,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Analyze your health data and provide monthly reports",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.text,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(7),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "• ",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.text,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Help you track your progress",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.text,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(7),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "• ",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.text,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Send smart notifications based on your condition",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.text,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Gap(10),
                Text(
                  "We promise:",
                  style: GoogleFonts.poppins(
                    color: AppColors.logo,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "• ",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.text,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Your data will not be shared with third parties",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.text,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(7),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "• ",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.text,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Secure storage using encrypted databases",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.text,
                            ),
                          ),
                        ),
                      ],
                    ),
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
