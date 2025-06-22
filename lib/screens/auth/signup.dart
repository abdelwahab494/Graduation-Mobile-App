import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/auth/auth_gate.dart';
import 'package:grad_project/auth/auth_service.dart';
import 'package:grad_project/components/custom_app_bar.dart';
import 'package:grad_project/screens/auth/login.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/components/customtextfield.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool isLoading = false;

  // form key
  final _formKey = GlobalKey<FormState>();

  // checkbox value
  bool _isTermsAccepted = false;

  // get auth service
  final authService = AuthService();

  // text controllers
  final _usernamecontroller = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // sign up button pressed
  Future<void> signup() async {
    // prepare data
    final email = _emailController.text;
    final username = _usernamecontroller.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    // ensure filling all fields
    if (email == "" ||
        username == "" ||
        password == "" ||
        confirmPassword == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color.fromARGB(220, 255, 17, 0),
          content: Text(
            "Please Fill All Fields to proceed.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
      return;
    }
    // cheching matching passwords
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color.fromARGB(220, 255, 17, 0),
          content: Text(
            "Password doesn't match! \nPlease try again.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
      return;
    }
    // checking terms
    if (!_isTermsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color.fromARGB(220, 255, 17, 0),
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
    }
    // attempt sign up
    try {
      await authService.signUpWithEmailPassword(email, password, username);
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const AuthGate()),
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usernamecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Focus.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.backGround,
        appBar: CustomAppBar(title: "Sign Up"),
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
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Gap(30),
                              CustomTextField(
                                controller: _usernamecontroller,
                                hint: "Name",
                                icon: Icons.person_outline_outlined,
                              ),
                              Gap(20),
                              OnlyEmailTextField(
                                controller: _emailController,
                                hint: "Email",
                                icon: Icons.mail_outline_outlined,
                              ),
                              Gap(20),
                              PasswordTextField(
                                controller: _passwordController,
                                hint: "Password",
                                icon: Icons.lock_outlined,
                              ),
                              Gap(20),
                              PasswordTextField(
                                controller: _confirmPasswordController,
                                hint: "Confirm password",
                                icon: Icons.lock_outlined,
                              ),
                              Gap(20),
                              CheckboxListTile(
                                checkColor: Colors.white,
                                activeColor: AppColors.primary,
                                contentPadding: EdgeInsets.zero,
                                value: _isTermsAccepted,
                                onChanged: (newValue) {
                                  setState(() {
                                    _isTermsAccepted = newValue!;
                                  });
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
                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          // start loading
                          setState(() => isLoading = true);
                          await signup();
                          // finish loading
                          setState(() => isLoading = false);
                        } else {
                          return;
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        width: 350,
                        decoration: BoxDecoration(
                          color:
                              _isTermsAccepted
                                  ? isLoading
                                      ? Colors.grey
                                      : AppColors.primary
                                  : Colors.grey,
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
                            color: AppColors.text,
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
            // border: Border.all(color: AppColors.primary),
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
