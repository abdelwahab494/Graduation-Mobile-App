import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:grad_project/components/custom_app_bar.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/providers/collect_info_provider.dart';
import 'package:provider/provider.dart';

class Prediction extends StatelessWidget {
  const Prediction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      appBar: CustomAppBar(title: "Diabetes Diagnosis"),
      body: Consumer<CollectInfoProvider>(
        builder: (context, provider, child) {
          return Center(
            child: Column(
              children: [
                Gap(50),
                Text("Age: ${provider.age.toString()}"),
                Text("Education: ${provider.education.toString()}"),
                Text("Income: ${provider.income.toString()}"),
                Gap(20),
                Text("Height: ${provider.height.toString()}"),
                Text("Weight: ${provider.weight.toString()}"),
                Text("BMI: ${provider.bmi.toString()}"),
                Text("GenHealth: ${provider.genHealth.toString()}"),
                Text("PhysHealth: ${provider.physHealth.toString()}"),
                Gap(20),
                Text("PhysActivity: ${provider.physActivity.toString()}"),
                Text("DiffWalk: ${provider.diffWalk.toString()}"),
                Gap(20),
                Text("RecentGL: ${provider.recentGL.toString()}"),
                Text("HighBP: ${provider.highBP.toString()}"),
                Text("HighChol: ${provider.highChol.toString()}"),
                Text("Stroke: ${provider.stroke.toString()}"),
                Text("HeartAttcke: ${provider.heartAttack.toString()}"),
              ],
            ),
          );
        },
      ),
    );
  }
}
