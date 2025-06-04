import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/Tools/colors.dart';
import 'package:grad_project/Auth/auth_service.dart';
import 'package:grad_project/Tools/functions.dart';
import 'package:grad_project/models.dart';

class Home extends StatefulWidget {
  final Function(int) onNavigate;
  const Home({super.key, required this.onNavigate});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // get auth service
  final authService = AuthService();

  // search controller
  final searchController = TextEditingController();

  // articles list
  List<ArticalesModel> articales = [
    ArticalesModel(
      title:
          "The 25 Healthiest Fruits You Can Eat, According to a Nutritionist",
      subTitle: "Jun 10, 2023 | 5min read",
      image: 1,
      isSaved: false,
    ),
    ArticalesModel(
      title: "The Impact of COVID-19 on Healthcare Systems",
      subTitle: "Jul 10, 2023 | 5min read",
      image: 2,
      isSaved: false,
    ),
    ArticalesModel(
      title: "Top 10 Tips for Managing Diabetes Naturally",
      subTitle: "Aug 15, 2023 | 6min read",
      image: 3,
      isSaved: false,
    ),
    ArticalesModel(
      title: "How to Boost Your Immune System This Winter",
      subTitle: "Sep 5, 2023 | 4min read",
      image: 4,
      isSaved: false,
    ),
    ArticalesModel(
      title: "Understanding Mental Health: Breaking the Stigma",
      subTitle: "Oct 20, 2023 | 7min read",
      image: 5,
      isSaved: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // get current username
    final currentusername = authService.getCurrentItem("name");

    return Scaffold(
      backgroundColor: Colors.lightBlue.shade100,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Gap(50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => widget.onNavigate(3),
                    child: AvatarGlow(
                      glowRadiusFactor: 0.25,
                      glowColor: AppColors.primary,
                      duration: Duration(milliseconds: 2000),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(
                          "assets/images/3bwhab2.jpg",
                        ),
                      ),
                    ),
                  ),
                  Gap(15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome !",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        currentusername,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 1,
                      ),
                      Gap(5),
                      Text(
                        "How is it going today ?",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      widget.onNavigate(2);
                    },
                    child: Icon(Icons.notifications, color: AppColors.primary),
                  ),
                ],
              ),
            ),
            Gap(25),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: searchController,
                    cursorColor: AppColors.primary,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      hintText: "Search doctor, drugs, articles...",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                          width: 1.2,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 14,
                      ),
                    ),
                  ),
                  Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(500),
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/Top Doctors.svg",
                              width: 35,
                            ),
                          ),
                          Gap(10),
                          Text(
                            "Top Doctors",
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(500),
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/Pharmacy.svg",
                              width: 35,
                            ),
                          ),
                          Gap(10),
                          Text(
                            "Pharmacy",
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(500),
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/Ambulance.svg",
                              width: 35,
                            ),
                          ),
                          Gap(10),
                          Text(
                            "Ambulance",
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Gap(25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Health articles",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "See all",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: articales.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: EdgeInsets.all(6),
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  "assets/images/articale${articales[index].image}.png",
                                  width: 55,
                                  fit: BoxFit.cover,
                                ),
                                Gap(10),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        articales[index].title,
                                        style: GoogleFonts.poppins(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        articales[index].subTitle,
                                        style: GoogleFonts.poppins(
                                          fontSize: 8,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Gap(5),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      articales[index].isSaved =
                                          !articales[index].isSaved;
                                    });
                                  },
                                  child: Icon(
                                    articales[index].isSaved
                                        ? Icons.bookmark
                                        : Icons.bookmark_border,
                                    color:
                                        articales[index].isSaved
                                            ? AppColors.primary
                                            : Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ChatBotton(),
    );
  }
}
