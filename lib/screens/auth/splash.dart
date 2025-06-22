// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:grad_project/Pages/info.dart';
// import 'package:grad_project/Pages/login.dart';
// import 'package:grad_project/Tools/colors.dart';
// import 'package:grad_project/providers/splash_provider.dart';
// import 'package:provider/provider.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     final isSplash = Provider.of<SplashProvider>(context).splash;
//     Future.delayed(Duration(seconds: 2), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (c) => isSplash ? Info() : Login()),
//       );
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backGround,
//       body: Center(
//         child: Stack(
//           children: [
//             Positioned(
//               child: Image.asset(
//                 "assets/icons/background.png",
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Positioned(
//               top: 0,
//               left: 0,
//               right: 0,
//               bottom: 0,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset("assets/icons/logo.png"),
//                   Gap(20),
//                   Text(
//                     "GlucoMate",
//                     style: GoogleFonts.poppins(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 32,
//                       color: AppColors.logo,
//                     ),
//                   ),
//                   Text(
//                     "Medical app",
//                     style: GoogleFonts.poppins(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 16,
//                       color: AppColors.logo,
//                     ),
//                   ),
//                 ],
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
import 'package:grad_project/screens/auth/info.dart';
import 'package:grad_project/screens/auth/login.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/providers/splash_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final splashProvider = Provider.of<SplashProvider>(context, listen: false);
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (c) => splashProvider.splash ? Info() : Login(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      body: Center(
        child: Stack(
          children: [
            Positioned(
              child: Image.asset(
                "assets/icons/background.png",
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/icons/logo.png"),
                  Gap(20),
                  Text(
                    "GlucoMate",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 32,
                      color: AppColors.logo,
                    ),
                  ),
                  Text(
                    "Medical app",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColors.logo,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}