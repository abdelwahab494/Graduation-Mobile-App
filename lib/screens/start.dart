// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:grad_project/Pages/login.dart';
// import 'package:grad_project/Pages/signup.dart';
// import 'package:grad_project/Tools/colors.dart';
// import 'package:grad_project/Tools/functions.dart';

// class Start extends StatelessWidget {
//   const Start({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backGround,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset("assets/icons/logo.png", width: 118),
//             Gap(10),
//             Text(
//               "GlucoMate",
//               style: GoogleFonts.poppins(
//                 fontWeight: FontWeight.w600,
//                 fontSize: 35,
//                 color: AppColors.logo,
//               ),
//             ),
//             Gap(30),
//             Text(
//               "Let’s get started!",
//               style: GoogleFonts.poppins(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.text,
//               ),
//             ),
//             Text(
//               "Login to Stay healthy and fit ",
//               style: GoogleFonts.poppins(
//                 fontSize: 16,
//                 fontWeight: FontWeight.normal,
//                 color: Colors.grey.shade600,
//               ),
//             ),
//             Gap(30),
//             botton("Login", () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (c) => Login()),
//               );
//             }),
//             Gap(15),
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (c) => Signup()),
//                 );
//               },
//               child: Container(
//                 padding: EdgeInsets.all(15),
//                 width: 250,
//                 decoration: BoxDecoration(
//                   color: Colors.transparent,
//                   border: Border.all(color: AppColors.primary, width: 2),
//                   borderRadius: BorderRadius.circular(50),
//                 ),
//                 child: Text(
//                   "Sign Up",
//                   textAlign: TextAlign.center,
//                   style: GoogleFonts.inter(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.primary,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/screens/login.dart';
import 'package:grad_project/Tools/colors.dart';
import 'package:grad_project/Tools/functions.dart';
import 'package:grad_project/providers/splash_provider.dart';
import 'package:grad_project/screens/signup_root.dart';
import 'package:provider/provider.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColors.backGround,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icons/logo.png", width: 118),
            Gap(10),
            Text(
              "GlucoMate",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 35,
                color: AppColors.logo,
              ),
            ),
            Gap(30),
            Text(
              "Let’s get started!",
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            Text(
              "Login to Stay healthy and fit ",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.grey.shade600,
              ),
            ),
            Gap(30),
            botton("Login", () async {
              await splashProvider.hideSplash();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (c) => Login()),
              );
            }),
            Gap(15),
            GestureDetector(
              onTap: () async {
                await splashProvider.hideSplash();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (c) => SignupRoot()),
                );
              },
              child: Container(
                padding: EdgeInsets.all(15),
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: AppColors.primary, width: 2),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  "Sign Up",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}