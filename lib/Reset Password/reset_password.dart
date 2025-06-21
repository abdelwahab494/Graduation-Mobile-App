import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/Tools/colors.dart';
import 'package:grad_project/Tools/functions.dart';
import 'package:grad_project/components/customtextfield.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key, required this.email});
  final String email;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final resetTokenC = TextEditingController();
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  final confirmPasswordC = TextEditingController();

  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    emailC.text = widget.email;
  }

  @override
  void dispose() {
    resetTokenC.dispose();
    emailC.dispose();
    passwordC.dispose();
    confirmPasswordC.dispose();
    super.dispose();
  }

  // Reset Password Function
  Future<void> _resetPassword() async {
    if (!formKey.currentState!.validate()) return;

    // Check if passwords match
    if (passwordC.text != confirmPasswordC.text) {
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
              content: Text("Passwords do not match. Please try again."),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("OK", style: TextStyle(color: AppColors.primary)),
                ),
              ],
            ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Verify the OTP (token) and reset password
      await supabase.auth.verifyOTP(
        email: emailC.text.trim(),
        token: resetTokenC.text.trim(),
        type: OtpType.recovery,
      );

      // Update the user's password
      await supabase.auth.updateUser(
        UserAttributes(password: passwordC.text.trim()),
      );

      if (mounted) {
        // Show success dialog
        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                backgroundColor: AppColors.backGround,
                title: Text(
                  "Success",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                ),
                content: Text("Your password has been reset successfully!"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context); // Back to login or home
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
        );
      }
    } catch (e) {
      // Show error dialog
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
                content: Text(
                  e.toString().contains("Invalid token")
                      ? "The token is invalid or expired. Please request a new one."
                      : "Something went wrong. Please try again later.",
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "OK",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      appBar: appBar(" RESET Password", context),
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
                  "Create new password",
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(10),
                Text(
                  "Enter your reset token from your email and set a new password.",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                Gap(30),
                CustomTextField(
                  controller: resetTokenC,
                  hint: "Reset Token",
                  icon: Icons.key_outlined,
                ),
                Gap(15),
                OnlyEmailTextField(
                  controller: emailC,
                  hint: "Email Address",
                  icon: Icons.email_outlined,
                ),
                Gap(15),
                PasswordTextField(
                  controller: passwordC,
                  hint: "New Password",
                  icon: Icons.lock_outline,
                ),
                Gap(15),
                PasswordTextField(
                  controller: confirmPasswordC,
                  hint: "Confirm Password",
                  icon: Icons.lock_outline,
                ),
                Gap(40),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : () => _resetPassword(),
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
                                "Reset Password",
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
            ),
          ),
        ),
      ),
    );
  }
}
