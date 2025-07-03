import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/auth/auth_service.dart';
import 'package:grad_project/screens/user%20info/collect_info.dart';

class StartQuize extends StatelessWidget {
  StartQuize({super.key});
  final bool isPartner = AuthService().getCurrentItemBool("isPartner");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              Color(0xFF223A6A),
              Color(0xFF36589B),
              Color(0xFF5B8FE5),
              Color(0xFF407CE2),
            ],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: Column(
          children: [
            Text(
              !isPartner
                  ? "Check Diabetes Risk"
                  : "Check Your Patient's Diabetes Risk",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: !isPartner ? 22 : 20,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(10),
            Text(
              !isPartner
                  ? "Answer a set of health-related questions to find out your likelihood of having diabetes based on your current and historical data."
                  : "Answer a set of health-related questions about your patient to determine their likelihood of having diabetes based on their current and historical data.",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(10),
            GestureDetector(
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => CollectInfo()),
                  ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  "Start Assessment",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
