import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/components/custom_app_bar.dart';
import 'package:grad_project/components/custom_botton.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/providers/collect_info_provider.dart';
import 'package:grad_project/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class DiabetesPrediction extends StatelessWidget {
  const DiabetesPrediction({super.key, required this.result});
  final int result;

  @override
  Widget build(BuildContext context) {
    final isLight = Provider.of<ChangeThemeProvider>(context).isLight;
    final TextEditingController feedbackController = TextEditingController();
    final collectInfoProvider = Provider.of<CollectInfoProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.backGround,
      appBar: CustomAppBar(title: "Diabetes Prediction"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    Text(
                      result <= 25.0
                          ? "No Diabetes\nDetected"
                          : "Diabetes \nDetected",
                      style: GoogleFonts.poppins(
                        color: result <= 25.0 ? Colors.green : Colors.red,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Gap(10),
                    SimpleCircularProgressBar(
                      mergeMode: true,
                      size: 120,
                      progressStrokeWidth: 10,
                      backStrokeWidth: 10,
                      backColor: Colors.transparent,
                      valueNotifier: ValueNotifier(result.toDouble()),
                      animationDuration: 2,
                      fullProgressColor: AppColors.primary,
                      progressColors: [AppColors.primary],
                      onGetText: (double value) {
                        return Text(
                          "${value.toInt()}%",
                          style: GoogleFonts.poppins(
                            color: AppColors.primary,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                    Gap(15),
                    Text(
                      "Confidence Based on analysis",
                      style: GoogleFonts.poppins(
                        color: AppColors.text,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Gap(10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "The prediction is based on the entered data, and there is a possibility of error. We recommend consulting a doctor to confirm.",
                        style: GoogleFonts.poppins(
                          color:
                              isLight
                                  ? Colors.grey.shade600
                                  : Colors.grey.shade400,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Gap(10),
                    CustomBotton(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      text: "Back",
                      width: 200,
                    ),
                  ],
                ),
              ),
              Gap(20),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: isLight ? Colors.grey.shade200 : Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    Text(
                      "Share Your Feedback",
                      style: GoogleFonts.poppins(
                        color: AppColors.text,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gap(10),
                    Text(
                      "We value your input on the prediction results.",
                      style: GoogleFonts.poppins(
                        color:
                            isLight
                                ? Colors.grey.shade600
                                : Colors.grey.shade300,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Gap(15),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: feedbackController,
                        decoration: InputDecoration(
                          hintText:
                              'How was your experience with the prediction result? Share your thoughts here...',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(12),
                        ),
                        maxLines: 3,
                      ),
                    ),
                    Gap(15),
                    CustomBotton(
                      onTap: () async {
                        await collectInfoProvider.submitFeedback(
                          feedbackController.text,
                        );

                        if (collectInfoProvider.result > -1) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Feedback Submitted Successfully.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                          return;
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Error Submitting Feedback!\nPlease try again.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                          return;
                        }
                      },
                      text: "Submit Feedback",
                    ),
                  ],
                ),
              ),
              Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}
