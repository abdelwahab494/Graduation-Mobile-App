import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/reset%20password/reset_password.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/components/custom_app_bar.dart';
import 'package:grad_project/components/customtextfield.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key, required this.email});
  final String email;

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final supabase = Supabase.instance.client;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    emailController.text = widget.email;
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      appBar: CustomAppBar(title: ""),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(20),
                Text(
                  "Forgor your password?",
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(10),
                Text(
                  "Enter your email address below and we'll send you a reset token.",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                Gap(30),
                OnlyEmailTextField(
                  controller: emailController,
                  hint: "Email Address",
                  icon: Icons.email_outlined,
                ),
                Gap(40),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : () => _requestResetToken(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        elevation: 0,
                      ),
                      child:
                          isLoading
                              ? CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              )
                              : Text(
                                "Send Reset Token",
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
                Gap(15),
                GestureDetector(
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (c) => ResetPassword(
                                email: emailController.text.trim(),
                              ),
                        ),
                      ),
                  child: Center(
                    child: Text(
                      "Already have a Token?",
                      style: TextStyle(color: AppColors.text, fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Request Reset Token
  Future<void> _requestResetToken() async {
    if (!formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    try {
      await supabase.auth.resetPasswordForEmail(emailController.text.trim());
      if (mounted) {
        // show success dialog
        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                backgroundColor: AppColors.backGround,
                title: Text(
                  "Check Your Email",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                ),
                content: Text(
                  "We've sent a reset token to your email. \n"
                  "Please check your inbox and use the token to reset your password.",
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (c) => ResetPassword(
                                email: emailController.text.trim(),
                              ),
                        ),
                      );
                    },
                    child: Text(
                      "CONTINUE",
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
        );
      }
    } catch (e) {
      String errorMessage;
      if (e.toString().contains("rate limit")) {
        errorMessage = "Too many requests. Please try again later.";
      } else if (e.toString().contains("invalid email")) {
        errorMessage = "Invalid email address.";
      } else {
        errorMessage = "Something went wrong. Please try again later.";
      }
      if (mounted) {
        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                backgroundColor: AppColors.backGround,
                title: Text(
                  "Error",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                ),
                content: Text(errorMessage),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "CANCEL",
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
