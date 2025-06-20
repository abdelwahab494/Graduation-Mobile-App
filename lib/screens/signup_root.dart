import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/Auth/auth_gate.dart';
import 'package:grad_project/Tools/colors.dart';
import 'package:grad_project/Tools/functions.dart';
import 'package:grad_project/providers/signup_provider.dart';
import 'package:provider/provider.dart';

class SignupRoot extends StatefulWidget {
  const SignupRoot({super.key});

  @override
  State<SignupRoot> createState() => _SignupRootState();
}

class _SignupRootState extends State<SignupRoot> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SignupProvider>(
      builder: (context, pageProvider, child) {
        return Scaffold(
          appBar: appBar(
            pageProvider.currentIndex == 0 ? "Sign Up" : "Information",
            context,
          ),
          body: pageProvider.pages[pageProvider.currentIndex],
          persistentFooterButtons: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      pageProvider.lastPage();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              pageProvider.currentIndex == 1
                                  ? AppColors.primary
                                  : Colors.white,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        pageProvider.currentIndex == 1 ? "Back" : "",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color:
                              pageProvider.currentIndex == 1
                                  ? AppColors.primary
                                  : Colors.white,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (pageProvider.currentIndex == 0) {
                        if (pageProvider.usernamecontroller.text == "" ||
                            pageProvider.emailController.text == "" ||
                            pageProvider.passwordController == "" ||
                            pageProvider.confirmPasswordController.text == "") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: const Color.fromARGB(
                                220,
                                255,
                                17,
                                0,
                              ),
                              content: Text(
                                "Error: \nPlease Fill All Fields To Continue.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                          return;
                        } else if (pageProvider.passwordController.text !=
                            pageProvider.confirmPasswordController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: const Color.fromARGB(
                                220,
                                255,
                                17,
                                0,
                              ),
                              content: Text(
                                "Error: \nPassword doesn't match! \nPlease try again.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                          return;
                        } else if (!pageProvider.isTermsAccepted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: const Color.fromARGB(
                                220,
                                255,
                                17,
                                0,
                              ),
                              content: Text(
                                "Please accept the Terms and Conditions to proceed.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                          return;
                        } else {
                          pageProvider.nextPage();
                        }
                      } else if (pageProvider.currentIndex == 1) {
                        try {
                          await pageProvider.authService.signUpWithEmailPassword(pageProvider.emailController.text, pageProvider.passwordController.text, pageProvider.usernamecontroller.text);
                          if (mounted) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const AuthGate()),
                              (route) => false,
                            );
                          }
                        } catch (e) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  "Please fill all fields with correct data!",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                          }
                        }
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color:
                            pageProvider.isTermsAccepted
                                ? AppColors.primary
                                : Colors.grey,
                        border: Border.all(
                          color:
                              pageProvider.isTermsAccepted
                                  ? AppColors.primary
                                  : Colors.grey,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        pageProvider.currentIndex == 0
                            ? "Next"
                            : "Create account",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          persistentFooterAlignment: AlignmentDirectional.center,
        );
      },
    );
  }
}
