import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:grad_project/Tools/colors.dart';
import 'package:grad_project/components/customtextfield.dart';

class CollectInfo extends StatelessWidget {
  CollectInfo({super.key});

  final TextEditingController _age = TextEditingController();
  final TextEditingController _weight = TextEditingController();

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
                icon: Icons.perm_contact_calendar_sharp,
              ),
              Gap(20),
              CustomTextField(
                controller: _weight,
                hint: "Weight",
                icon: Icons.account_balance_wallet,
              ),
              Gap(20),
              CustomTextField(
                controller: _weight,
                hint: "Weight",
                icon: Icons.account_balance_wallet,
              ),
              Gap(20),
              CustomTextField(
                controller: _weight,
                hint: "Weight",
                icon: Icons.account_balance_wallet,
              ),
              Gap(20),
              CustomTextField(
                controller: _weight,
                hint: "Weight",
                icon: Icons.account_balance_wallet,
              ),
              Gap(20),
              CustomTextField(
                controller: _weight,
                hint: "Weight",
                icon: Icons.account_balance_wallet,
              ),
              Gap(20),
              CustomTextField(
                controller: _weight,
                hint: "Weight",
                icon: Icons.account_balance_wallet,
              ),
              Gap(20),
              CustomTextField(
                controller: _weight,
                hint: "Weight",
                icon: Icons.account_balance_wallet,
              ),
              Gap(20),
              CustomTextField(
                controller: _weight,
                hint: "Weight",
                icon: Icons.account_balance_wallet,
              ),
              Gap(20),
              CustomTextField(
                controller: _weight,
                hint: "Weight",
                icon: Icons.account_balance_wallet,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
