import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/components/collect%20info%20components/age_section.dart';
import 'package:grad_project/components/collect%20info%20components/education_section.dart';
import 'package:grad_project/components/collect%20info%20components/health_metrics_section.dart';
import 'package:grad_project/components/collect%20info%20components/income_section.dart';
import 'package:grad_project/components/collect%20info%20components/lifestyle_section.dart';
import 'package:grad_project/components/collect%20info%20components/medical_history_section.dart';
import 'package:grad_project/components/custom_app_bar.dart';
import 'package:grad_project/components/custom_botton.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/providers/collect_info_provider.dart';
import 'package:grad_project/providers/theme_provider.dart';
import 'package:grad_project/screens/user%20info/diabetes_prediction.dart';
import 'package:provider/provider.dart';

class CollectInfo extends StatefulWidget {
  CollectInfo({super.key});

  @override
  State<CollectInfo> createState() => _CollectInfoState();
}

class _CollectInfoState extends State<CollectInfo> {
  // controllers
  final TextEditingController heightC = TextEditingController();
  final TextEditingController weightC = TextEditingController();
  final TextEditingController physHealthC = TextEditingController();
  // final TextEditingController recentGLC = TextEditingController();

  // form key
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();

  @override
  void dispose() {
    heightC.dispose();
    weightC.dispose();
    physHealthC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Provider.of<ChangeThemeProvider>(context).isLight;

    return Consumer<CollectInfoProvider>(
      builder: (context, provider, child) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: AppColors.backGround,
            appBar: CustomAppBar(title: "Diabetes Risk Assessment"),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Personal Information",
                            style: GoogleFonts.poppins(
                              color: AppColors.text,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Divider(),
                          Gap(10),
                          // age
                          AgeSection(isLight: isLight),
                          Gap(10),
                          // education
                          EducationSection(isLight: isLight),
                          Gap(10),
                          // income
                          IncomeSection(isLight: isLight),
                        ],
                      ),
                    ),
                    Gap(10),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Health Metrics",
                            style: GoogleFonts.poppins(
                              color: AppColors.text,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Divider(),
                          Gap(10),
                          HealthMetricsSection(
                            isLight: isLight,
                            heightC: heightC,
                            weightC: weightC,
                            formKey: formKey1,
                            physHealthC: physHealthC,
                          ),
                        ],
                      ),
                    ),
                    Gap(10),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Lifestyle Factors",
                            style: GoogleFonts.poppins(
                              color: AppColors.text,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Divider(),
                          Gap(10),
                          LifestyleSection(isLight: isLight),
                        ],
                      ),
                    ),
                    Gap(10),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Medical History & Other",
                            style: GoogleFonts.poppins(
                              color: AppColors.text,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Divider(),
                          Gap(10),
                          MedicalHistorySection(
                            isLight: isLight,
                            formKey: formKey2,
                          ),
                        ],
                      ),
                    ),
                    Gap(15),
                    CustomBotton(
                      onTap: () async {
                        if (!formKey1.currentState!.validate() ||
                            !formKey2.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Please fill all fields to proceed!",
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder:
                              (context) => Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primary,
                                ),
                              ),
                        );

                        provider.height = int.parse(heightC.text);
                        provider.weight = int.parse(weightC.text);
                        provider.physHealth = int.parse(physHealthC.text);
                        // provider.recentGL = int.parse(recentGLC.text);

                        await provider.predictFromServer();

                        Navigator.pop(context);

                        if (provider.result.toLowerCase().contains("error")) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Error trying to predict your diabetes condition!\nPlease try again later.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (c) =>
                                    DiabetesPrediction(result: provider.result),
                          ),
                        );
                      },
                      text: "Predict My Status",
                      width: double.infinity,
                    ),
                    Gap(25),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
