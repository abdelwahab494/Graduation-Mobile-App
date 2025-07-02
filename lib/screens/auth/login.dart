import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/components/customtextfield.dart';
import 'package:grad_project/auth/auth_gate.dart';
import 'package:grad_project/auth/auth_service.dart';
import 'package:grad_project/reset%20password/forgot_password.dart';
import 'package:grad_project/screens/auth/root.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;

  // form key
  final _formKey = GlobalKey<FormState>();

  // get auth service
  final authService = AuthService();

  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // login button pressed
  void login() async {
    // start loading
    setState(() => isLoading = true);

    // prepare data
    final email = _emailController.text;
    final password = _passwordController.text;

    // attempt login
    try {
      await authService.signInWithEmailPassword(email, password);
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const AuthGate()),
          (route) => false,
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color.fromARGB(220, 255, 17, 0),
          content: Text(
            "Error: \nEmail or Password are incorrect! \nPlease try again.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    // finish loading
    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.backGround,
        appBar: AppBar(
          backgroundColor: AppColors.backGround,
          elevation: 0,
          scrolledUnderElevation: 0.0,
          centerTitle: true,
          title: Text(
            "Login",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Gap(30),
                OnlyEmailTextField(
                  controller: _emailController,
                  hint: "Enter your email",
                  icon: Icons.mail_outline_outlined,
                ),
                SizedBox(height: 20),
                PasswordTextField(
                  controller: _passwordController,
                  hint: "Enter your password",
                  icon: Icons.lock_outlined,
                ),
                Gap(10),
                GestureDetector(
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (c) => ForgotPassword(
                                email: _emailController.text.trim(),
                              ),
                        ),
                      ),
                  child: Align(
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
                ),
                Gap(30),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      isLoading ? null : login();
                    } else {
                      return;
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    width: 350,
                    decoration: BoxDecoration(
                      color: !isLoading ? AppColors.primary : Colors.grey,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child:
                        isLoading
                            ? Container(
                              width: 30,
                              height: 30,
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            )
                            : Text(
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
                Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t have an account?",
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
                          MaterialPageRoute(builder: (context) => Root()),
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
                Gap(120),
                // Column(
                //   children: [
                //     SvgPicture.asset("assets/icons/hr.svg"),
                //     Gap(20),
                //     Container(
                //       alignment: Alignment.center,
                //       decoration: BoxDecoration(
                //         border: Border.all(
                //           width: 1,
                //           color: Colors.grey.shade300,
                //         ),
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //       child: Padding(
                //         padding: const EdgeInsets.all(18),
                //         child: Row(
                //           children: [
                //             Gap(10),
                //             SvgPicture.asset("assets/icons/Google.svg"),
                //             Gap(30),
                //             Text(
                //               "Sign in with Google",
                //               style: GoogleFonts.poppins(
                //                 fontSize: 16,
                //                 fontWeight: FontWeight.w600,
                //                 color: AppColors.text,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //     Gap(15),
                //     Container(
                //       alignment: Alignment.center,
                //       decoration: BoxDecoration(
                //         border: Border.all(
                //           width: 1,
                //           color: Colors.grey.shade300,
                //         ),
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //       child: Padding(
                //         padding: const EdgeInsets.all(18),
                //         child: Row(
                //           children: [
                //             Gap(10),
                //             SvgPicture.asset("assets/icons/Facebook.svg"),
                //             Gap(30),
                //             Text(
                //               "Sign in with Facebook",
                //               style: GoogleFonts.poppins(
                //                 fontSize: 16,
                //                 fontWeight: FontWeight.w600,
                //                 color: AppColors.text,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //     Gap(40),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
