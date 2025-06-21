import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:grad_project/Tools/colors.dart';
import 'package:grad_project/components/customtextfield.dart';

class CollectInfo extends StatelessWidget {
  CollectInfo({super.key});

  final TextEditingController _age = TextEditingController();
  final TextEditingController _bmi = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(30),
              CustomTextField(
                controller: _age,
                hint: "Age",
                icon: Icons.question_mark,
              ),
              Gap(20),
              CustomTextField(
                controller: _bmi,
                hint: "BMI",
                icon: Icons.question_mark,
              ),
              Gap(20),
              CustomTextField(
                controller: _bmi,
                hint: "High Blood Pressure",
                icon: Icons.question_mark,
              ),
              Gap(20),
              CustomTextField(
                controller: _bmi,
                hint: "Have you ever had a stroke",
                icon: Icons.question_mark,
              ),
              Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}
