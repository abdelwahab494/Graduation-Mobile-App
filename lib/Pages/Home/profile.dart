import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/Pages/issues.dart';
import 'package:grad_project/Tools/functions.dart';
import 'package:grad_project/auth/auth_service.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // get auth service
  final authService = AuthService();

  void logout() async {
    await authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Gap(60),
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("assets/images/3bwhab2.jpg"),
            ),
            Gap(8),
            Text(
              maxLines: 1,
              authService.getCurrentItem("name"),
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  information(
                    "assets/icons/Heartbeat.svg",
                    "Heart rate",
                    "215bmp",
                  ),
                  information("assets/icons/Fire.svg", "Calories", "756cal"),
                  information("assets/icons/weight.svg", "Weight", "68kg"),
                ],
              ),
            ),
            Gap(15),
            Column(
              children: [
                cards("My Saved", "assets/icons/heart.svg"),
                Gap(5),
                cards("Appointment", "assets/icons/calender.svg"),
                Gap(5),
                cards("Payment Method", "assets/icons/wallet.svg"),
                Gap(5),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (c) => Issues()),
                    );
                  },
                  child: cards("Common Issues", "assets/icons/message.svg"),
                ),
                Gap(5),
                GestureDetector(
                  onTap: () => logout(),
                  child: cards("Logout", "assets/icons/logout.svg"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
