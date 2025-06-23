import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/auth/auth_service.dart';
import 'package:grad_project/components/custom_app_bar.dart';
import 'package:grad_project/components/custom_botton.dart';
import 'package:grad_project/components/customtextfield.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/providers/profile_image_provider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccountInfo extends StatefulWidget {
  AccountInfo({super.key});

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  // loading
  bool isLoading = false;

  // controllers
  final TextEditingController nameC = TextEditingController();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();

  // auth services
  final authService = AuthService();

  // form key
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    nameC.text = authService.getCurrentItem("name");
    emailC.text = authService.getCurrentEmail().toString();
    super.initState();
  }

  Future<void> saveChanges() async {
    setState(() => isLoading = true);

    try {
      final supabase = Supabase.instance.client;

      // Update email & password
      await supabase.auth.updateUser(
        UserAttributes(
          email: emailC.text.trim(),
          password: passwordC.text.trim(),
          data: {'name': nameC.text.trim()},
        ),
      );

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Account info updated successfully")),
      );
    } catch (e) {
      print("Error updating user: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to update account info")));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    nameC.dispose();
    emailC.dispose();
    passwordC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.backGround,
        appBar: CustomAppBar(title: "Account Information"),
        body: Consumer<ProfileImageProvider>(
          builder: (context, provider, child) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Gap(30),
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 70,
                                backgroundColor: AppColors.backGround,
                                backgroundImage:
                                    provider.selectedImage == null
                                        ? AssetImage("assets/images/user.png")
                                        : FileImage(
                                          File(provider.selectedImage!.path),
                                        ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: provider.uploadImage,
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(500),
                                    ),
                                    child: Icon(
                                      Icons.edit,
                                      color: AppColors.backGround,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gap(15),
                          Text(
                            maxLines: 1,
                            authService.getCurrentItem("name"),
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap(20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Full Name",
                              style: GoogleFonts.poppins(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Gap(10),
                          CustomTextField(
                            controller: nameC,
                            hint: "",
                            icon: Icons.person,
                          ),
                          Gap(20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Email",
                              style: GoogleFonts.poppins(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Gap(10),
                          OnlyEmailTextField(
                            controller: emailC,
                            hint: "",
                            icon: Icons.alternate_email,
                            readOnly: true,
                          ),
                          Gap(20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Password",
                              style: GoogleFonts.poppins(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Gap(10),
                          PasswordTextField(
                            controller: passwordC,
                            hint: "",
                            icon: Icons.password,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child:
                isLoading
                    ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    )
                    : CustomBotton(
                      onTap: () {
                        if (!formKey.currentState!.validate()) return;
                        saveChanges();
                      },
                      text: "Save Changes",
                    ),
          ),
        ),
      ),
    );
  }
}
