import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/Tools/colors.dart';
import 'package:grad_project/Auth/auth_service.dart';
import 'package:grad_project/Tools/functions.dart';
import 'package:grad_project/models.dart';
import 'package:grad_project/Pages/chatbot/chatbot.dart';
import 'package:grad_project/providers/profile_image_provider.dart';
import 'package:provider/provider.dart';

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
  bool _isLoadingTips = false;
  List<String> _healthTips = [];

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
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> _showHealthTips() async {
    setState(() => _isLoadingTips = true);

    try {
      final tips = await Chatbot.getHealthTips(
        age: "35", // These should come from user profile
        gender: "Male",
        medicalCondition: "Type 2 Diabetes",
        lifestyle: "Sedentary, works in office",
      );

      if (mounted) {
        setState(() {
          _healthTips = tips;
          _isLoadingTips = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingTips = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load health tips. Please try again.'),
          ),
        );
      }
    }
  }

  Widget _buildHealthTipsSection() {
    if (_isLoadingTips) {
      return Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          margin: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      );
    }

    if (_healthTips.isEmpty) {
      return Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Today's Health Tips",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Tap to get your today's personalized health tips",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: _showHealthTips,
                  icon: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.health_and_safety,
                      color: Colors.white,
                      size: 23,
                    ),
                  ),
                  tooltip: 'Get Health Tips',
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Container(
      height: 400,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Your Today's Health Tips",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: Icon(Icons.refresh, color: AppColors.primary),
                onPressed: _showHealthTips,
                tooltip: 'Refresh Tips',
              ),
            ],
          ),
          Gap(8),
          SizedBox(
            height: 300,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  ...List.generate(
                    _healthTips.length,
                    (index) => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '${index + 1}',
                                  style: GoogleFonts.poppins(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Gap(8),
                              Expanded(
                                child: Text(
                                  _healthTips[index],
                                  style: GoogleFonts.poppins(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                        index == 4
                            ? SizedBox.shrink()
                            : Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                              ),
                              child: Divider(
                                thickness: 1,
                                color: Colors.grey.shade300,
                              ),
                            ),
                        Gap(5),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // get current username
    final currentusername = authService.getCurrentItem("name");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileImageProvider>(context, listen: false).loadImage();
    });

    return Scaffold(
      backgroundColor: Colors.lightBlue.shade100,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Gap(50), // Reduced gap since we now have AppBar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  Consumer<ProfileImageProvider>(
                    builder: (context, imageProvider, child) {
                      return GestureDetector(
                        onTap: () => widget.onNavigate(3),
                        child: AvatarGlow(
                          glowRadiusFactor: 0.25,
                          glowColor: AppColors.primary,
                          duration: Duration(milliseconds: 2000),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                imageProvider.selectedImage == null
                                    ? AssetImage("assets/images/user.png")
                                    : FileImage(
                                      File(imageProvider.selectedImage!.path),
                                    ),
                          ),
                        ),
                      );
                    },
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
                  Gap(15),
                  _buildHealthTipsSection(),
                  Gap(15),
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
