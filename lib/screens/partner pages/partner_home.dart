import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:grad_project/auth/auth_service.dart';
import 'package:grad_project/components/welcome_user.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/providers/profile_image_provider.dart';
import 'package:provider/provider.dart';

class PartnerHome extends StatefulWidget {
  PartnerHome({super.key, required this.onNavigate});
  final Function(int) onNavigate;

  @override
  State<PartnerHome> createState() => _PartnerHomeState();
}

class _PartnerHomeState extends State<PartnerHome> {
  final bool isPartner = AuthService().getCurrentItemBool("isPartner");

  // get auth service
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    // get current username
    final currentusername = authService.getCurrentItemString("name");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileImageProvider>(context, listen: false).loadImage();
    });

    return Scaffold(
      backgroundColor: Color(0xFFC4DAFF),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Gap(50),
            WelcomeUser(
              onNavigate: widget.onNavigate,
              currentusername: currentusername,
              isPartner: isPartner,
            ),
            Gap(25),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.backGround,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Column(children: [
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
