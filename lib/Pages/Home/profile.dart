import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/Pages/login.dart';
import 'package:grad_project/Tools/functions.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

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
              "Abdelwahab",
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
                cards("Patment Method", "assets/icons/wallet.svg"),
                Gap(5),
                cards("FAQs", "assets/icons/message.svg"),
                Gap(5),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (c) => Login()),
                    );
                  },
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
