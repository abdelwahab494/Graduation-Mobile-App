import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/components/dashboard.dart';
import 'package:grad_project/database/glucose_measurements/glucose_measurements.dart';
import 'package:grad_project/database/glucose_measurements/glucose_measurements_database.dart';
import 'package:grad_project/database/user_health_data/user_health_data.dart';
import 'package:grad_project/database/user_health_data/user_health_database.dart';
import 'package:grad_project/screens/measure/loading_screen.dart';
import 'package:grad_project/screens/measure/measurement_page.dart';
import 'package:grad_project/screens/measure/reading_history.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:grad_project/core/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:grad_project/auth/auth_service.dart';
import 'package:grad_project/components/chat_botton.dart';
import 'package:grad_project/models/articales_model.dart';
import 'package:grad_project/components/home_buttons.dart';
import 'package:grad_project/components/welcome_user.dart';
import 'package:grad_project/components/measure_botton.dart';
import 'package:grad_project/providers/health_tips_provider.dart';
import 'package:grad_project/providers/profile_image_provider.dart';

class Home extends StatefulWidget {
  final Function(int) onNavigate;
  const Home({super.key, required this.onNavigate});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  UserHealthData? userData;
  final bool isPartner = AuthService().getCurrentItemBool("isPartner");
  final _streamKey = GlobalKey();

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
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchLatestData() async {
    try {
      final data = await UserHealthDatabase().getLatestUserHealthData();
      setState(() {
        userData = data!;
      });
    } catch (e) {
      print('Error fetching latest data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Failed to load health tips! Please try again.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _showHealthTips() async {
    final provider = Provider.of<HealthTipsProvider>(context, listen: false);
    try {
      await _fetchLatestData();
      await provider.fetchHealthTips(userData);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Failed to load health tips! Please try again.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Widget _buildHealthTipsSection() {
    return Consumer<HealthTipsProvider>(
      builder: (context, provider, child) {
        if (provider.isLoadingTips) {
          return Skeletonizer(
            child: Container(
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
                          color: AppColors.text,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.refresh, color: AppColors.primary),
                        onPressed: _showHealthTips,
                        tooltip: 'Refresh Tips',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 300,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: articales.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "$index",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Gap(10),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Incorporate 30 minutes of moderate-intensity exercise most days of the week: Start with short walks during your lunch break or after work, gradually increasing duration and intensity.",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.text,
                                      ),
                                    ),
                                    Gap(10),
                                    Divider(),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (provider.healthTips.isEmpty) {
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
                    color: AppColors.text,
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
                          color: AppColors.backGround,
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
                      color: AppColors.text,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.refresh, color: AppColors.primary),
                        onPressed: _showHealthTips,
                        tooltip: 'Refresh Tips',
                        iconSize: 20,
                      ),
                      IconButton(
                        icon: Icon(Icons.clear, color: Colors.red),
                        onPressed: provider.clearHealthTips,
                        tooltip: 'Clear Tips',
                        iconSize: 20,
                      ),
                    ],
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
                        provider.healthTips.length,
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
                                      provider.healthTips[index],
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: AppColors.text,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            index == provider.healthTips.length - 1
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isPartner = authService.getCurrentItemBool("isPartner");
    final db = GlucoseMeasurementsDatabase();
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
            ),
            Gap(25),
            Container(
              padding:
                  !isPartner
                      ? EdgeInsets.symmetric(vertical: 20, horizontal: 25)
                      : EdgeInsets.zero,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.backGround,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Column(
                children: [
                  isPartner
                      ? SizedBox.shrink()
                      : Column(
                        children: [
                          // CustomSearchBar(searchController: searchController),
                          Gap(20),
                          HomeButtons(onNavigate: widget.onNavigate),
                          Gap(30),
                          GestureDetector(
                            onTap:
                                () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (c) => MeasurementPage(),
                                  ),
                                ),
                            child: MeasureBotton(),
                          ),
                          Gap(30),
                          _buildHealthTipsSection(),
                          // HealthArticales(articales: articales),
                        ],
                      ),
                  Gap(15),
                  !isPartner
                      ? GestureDetector(
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (c) => ReadingHistory(),
                              ),
                            ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              !isPartner
                                  ? "Recent Glucose Readings"
                                  : "Your Patient's Glucose Readings",
                              style: GoogleFonts.poppins(
                                color: AppColors.text,
                                fontSize: !isPartner ? 16 : 14,
                                fontWeight: FontWeight.w700,
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
                      )
                      : SizedBox.shrink(),
                  !isPartner
                      ? StreamBuilder<List<GlucoseMeasurements>>(
                        key: _streamKey,
                        stream: db.stream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              child: Center(
                                child: Column(
                                  children: [
                                    CircularProgressIndicator(
                                      color: AppColors.primary,
                                    ),
                                    Gap(300),
                                  ],
                                ),
                              ),
                            );
                          }
                          if (snapshot.hasError) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      'Something went wrong!\n Please check your connection.',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.text,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Gap(300),
                                  ],
                                ),
                              ),
                            );
                          }
                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      'No History yet.',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.text,
                                      ),
                                    ),
                                    Gap(300),
                                  ],
                                ),
                              ),
                            );
                          }
                          final measurements = snapshot.data!;
                          return Column(
                            children: [
                              Gap(15),
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:
                                    isPartner
                                        ? measurements.length
                                        : (measurements.length <= 4
                                            ? measurements.length
                                            : 5),
                                itemBuilder: (BuildContext context, int index) {
                                  final measurement = measurements[index];
                                  Color color;
                                  Color bcolor;
                                  IconData icon;
                                  if (measurement.glucose <= 54) {
                                    icon = Icons.warning_rounded;
                                    color = Colors.red.shade700;
                                    bcolor = Colors.red.shade100;
                                  } else if (measurement.glucose < 70 &&
                                      measurement.glucose > 54) {
                                    icon =
                                        CupertinoIcons.arrow_down_circle_fill;
                                    color = Colors.orange;
                                    bcolor = Colors.orange.shade100;
                                  } else if (measurement.glucose >= 70 &&
                                      measurement.glucose <= 140) {
                                    icon =
                                        CupertinoIcons
                                            .checkmark_alt_circle_fill;
                                    color = Colors.green;
                                    bcolor = Colors.green.shade100;
                                  } else if (measurement.glucose > 140 &&
                                      measurement.glucose < 220) {
                                    icon = CupertinoIcons.arrow_up_circle_fill;
                                    color = Colors.orange;
                                    bcolor = Colors.orange.shade100;
                                  } else {
                                    icon = Icons.warning_rounded;
                                    color = Colors.red.shade700;
                                    bcolor = Colors.red.shade100;
                                  }
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 15,
                                    ),
                                    margin: EdgeInsets.only(bottom: 12),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: bcolor,
                                            borderRadius: BorderRadius.circular(
                                              500,
                                            ),
                                          ),
                                          child: Icon(
                                            icon,
                                            color: color,
                                            size: 35,
                                          ),
                                        ),
                                        Gap(20),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  measurement.glucose
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                    color: color,
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Gap(5),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        bottom: 4,
                                                      ),
                                                  child: Text(
                                                    "mg/dl",
                                                    style: GoogleFonts.poppins(
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              DateFormat(
                                                'MMM d, y, h:mm a',
                                              ).format(measurement.created_at),
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey.shade600,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      )
                      : Dashboard(onNavigate: widget.onNavigate),
                  Gap(30),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: !isPartner ? ChatBotton() : SizedBox.shrink(),
    );
  }
}
