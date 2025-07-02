import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/components/custom_app_bar.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/screens/auth/partner_signup.dart';
import 'package:grad_project/screens/auth/patient_signup.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  bool isPartner() {
    if (_selectedIndex == 0) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      PatientSignup(isPartner: isPartner()),
      PartnerSignup(isPartner: isPartner()),
    ];
    return Scaffold(
      backgroundColor: AppColors.backGround,
      appBar: CustomAppBar(title: "Signup"),
      body: Column(
        children: [
          Gap(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => _onItemTapped(0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color:
                          _selectedIndex == 0
                              ? AppColors.primary
                              : AppColors.backGround,
                      border: Border.all(color: AppColors.primary, width: 2),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      "Patient",
                      style: GoogleFonts.poppins(
                        color:
                            _selectedIndex == 0
                                ? Colors.white
                                : AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _onItemTapped(1),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color:
                          _selectedIndex == 1
                              ? AppColors.primary
                              : AppColors.backGround,
                      border: Border.all(color: AppColors.primary, width: 2),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      "Partner",
                      style: GoogleFonts.poppins(
                        color:
                            _selectedIndex == 1
                                ? Colors.white
                                : AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: _pages[_selectedIndex]),
        ],
      ),
    );
  }
}
