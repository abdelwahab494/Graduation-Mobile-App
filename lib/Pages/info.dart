import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/Pages/start.dart';
import 'package:grad_project/Tools/colors.dart';
import 'package:grad_project/models.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  List<InfoModel> info = [
    InfoModel(
      name: "Find a lot of specialist doctors in one place",
      image: "assets/images/info_doc1.png",
    ),
    InfoModel(
      name: "Get advice only from a doctor you believe in.",
      image: "assets/images/info_doc2.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Gap(60),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 25),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => Start()),
                  );
                },
                child: Text(
                  "Skip",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Color(0xffA1A8B0),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: info.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Gap(50),
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: Image.asset(
                            info[index].image,
                            fit: BoxFit.contain,
                            width: 296,
                          ),
                        ),
                      ),
                    ),
                    Gap(20),
                    SizedBox(
                      width: 300,
                      child: Text(
                        info[index].name,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40, left: 20, right: 20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(info.length, (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 3),
                        width: _currentIndex == index ? 16 : 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color:
                              _currentIndex == index
                                  ? AppColors.primary
                                  : Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      );
                    }),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_currentIndex < info.length - 1) {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (c) => Start()),
                        );
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.arrow_forward, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Gap(30),
        ],
      ),
    );
  }
}
