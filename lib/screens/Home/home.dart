import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/auth/auth_service.dart';
import 'package:grad_project/components/chat_botton.dart';
import 'package:grad_project/components/home_buttons.dart';
import 'package:grad_project/components/measure_botton.dart';
import 'package:grad_project/components/welcome_user.dart';
import 'package:grad_project/models/articales_model.dart';
import 'package:grad_project/screens/chatbot/chatbot.dart';
import 'package:grad_project/providers/profile_image_provider.dart';
import 'package:grad_project/screens/measurements.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
        age: "35",
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Incorporate 30 minutes of moderate-intensity exercise most days of the week: Start with short walks during your lunch break or after work, gradually increasing duration and intensity.",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
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
    // if (_isLoadingTips) {
    //   return Center(
    //     child: Container(
    //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    //       margin: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
    //       decoration: BoxDecoration(
    //         border: Border.all(color: Colors.grey.shade300, width: 1),
    //         borderRadius: BorderRadius.circular(5),
    //       ),
    //       child: CircularProgressIndicator(color: AppColors.primary),
    //     ),
    //   );
    // }

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

    if (!_healthTips.isEmpty) {
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
    } else {
      return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    // get current username
    final currentusername = authService.getCurrentItem("name");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileImageProvider>(context, listen: false).loadImage();
    });

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 196, 218, 255),
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
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
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
                  // CustomSearchBar(searchController: searchController),
                  Gap(20),
                  HomeButtons(),
                  Gap(35),
                  GestureDetector(
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => MeasurementScreen(),
                          ),
                        ),
                    child: MeasureBotton(),
                  ),
                  Gap(35),
                  _buildHealthTipsSection(),
                  Gap(15),
                  // HealthArticales(articales: articales),
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
