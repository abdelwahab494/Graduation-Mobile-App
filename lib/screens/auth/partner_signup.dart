import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/auth/auth_gate.dart';
import 'package:grad_project/auth/auth_service.dart';
import 'package:grad_project/components/customtextfield.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/providers/theme_provider.dart';
import 'package:grad_project/screens/auth/login.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class PartnerSignup extends StatefulWidget {
  const PartnerSignup({super.key, required this.isPartner});
  final bool isPartner;

  @override
  State<PartnerSignup> createState() => _PartnerSignupState();
}

class _PartnerSignupState extends State<PartnerSignup> {
  bool isLoading = false;
  bool agree = false;

  // form key
  final _formKey = GlobalKey<FormState>();

  // get auth service
  final authService = AuthService();

  // text controllers
  final _usernamecontroller = TextEditingController();
  final _emailController = TextEditingController();
  final _patientIDController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // sign up button pressed
  Future<void> signup() async {
    // prepare data
    final patientID = _patientIDController.text.trim();
    final email = _emailController.text.trim();
    final username = _usernamecontroller.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    // ensure filling all fields
    if (email == "" ||
        username == "" ||
        password == "" ||
        confirmPassword == "" ||
        patientID == "") {
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

    // check matching passwords
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

    // validate patientID as UUID
    try {
      Uuid.parse(patientID);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color.fromARGB(220, 255, 17, 0),
          content: Text(
            "Invalid Patient ID format. Please enter a valid UUID.",
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
      await authService.signUpWithEmailPassword(
        email,
        password,
        username,
        agree,
        widget.isPartner,
        patientID,
      );
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
    _patientIDController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usernamecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Gap(30),
                              TextFormField(
                                controller: _patientIDController,
                                cursorColor: Colors.black,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'[a-zA-Z0-9 -]'),
                                  ),
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please fill this field to proceed.";
                                  }
                                  if (!value.contains("-")) {
                                    return "Invalid ID Format!";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.paste,
                                      color: Colors.grey[700],
                                    ),
                                    onPressed: () async {
                                      final clipboardData =
                                          await Clipboard.getData('text/plain');
                                      if (clipboardData != null &&
                                          clipboardData.text != null) {
                                        _patientIDController.text =
                                            clipboardData.text!;
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Text pasted from clipboard!',
                                            ),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'No text found in clipboard!',
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  hintText: "Patient ID",
                                  hintStyle: TextStyle(
                                    color:
                                        Provider.of<ChangeThemeProvider>(
                                              context,
                                            ).isLight
                                            ? Color.fromARGB(255, 73, 73, 73)
                                            : Color(0xffF2F2F2),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.numbers,
                                    color: Colors.grey[700],
                                  ),
                                  filled: true,
                                  fillColor:
                                      Provider.of<ChangeThemeProvider>(
                                            context,
                                          ).isLight
                                          ? Color(0xffF2F2F2)
                                          : Color.fromARGB(255, 73, 73, 73),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 18.0,
                                    horizontal: 16.0,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                                style: TextStyle(color: AppColors.text),
                              ),
                              Gap(40),
                              CustomTextField(
                                controller: _usernamecontroller,
                                hint: "Partner Name",
                                icon: Icons.person_outline_outlined,
                              ),
                              Gap(20),
                              OnlyEmailTextField(
                                controller: _emailController,
                                hint: "Partner Email",
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
                                value: agree,
                                onChanged: (newValue) {
                                  setState(() {
                                    agree = newValue!;
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
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        width: 350,
                        decoration: BoxDecoration(
                          color: isLoading ? Colors.grey : AppColors.primary,
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
                                  "Create partner account",
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

  Future _showDialog(context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          contentPadding: EdgeInsets.all(15),
          backgroundColor: Colors.white,
          title: Text(
            "Privacy & Security Policy.",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
              fontSize: 25,
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
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 250,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 247, 250, 255),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "We care about your patient's privacy. We kindly ask for your consent to:",
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
                                  "Analyze your patient's health data and provide monthly reports.",
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
                                  "Help you monitor your patient's progress.",
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
                                  "Send smart notifications based on your patient's condition.",
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
                                  "Your patient’s data will not be shared with third parties.",
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
                                  "Data will be securely stored using encrypted databases",
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
              Gap(5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Text(
                  "!  With your consent, we may use your\n   patient's anonymized medical data to\n   improve our models, enhancing the\n   accuracy of diagnoses and\n   measurements.",
                  style: GoogleFonts.poppins(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
