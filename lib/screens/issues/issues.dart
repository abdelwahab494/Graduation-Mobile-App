import 'package:flutter/material.dart';
import 'package:grad_project/components/common_issue.dart';
import 'package:grad_project/components/custom_app_bar.dart';
import 'package:grad_project/screens/issues/issue_details.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/core/globals.dart';

class Issues extends StatefulWidget {
  const Issues({super.key});

  @override
  State<Issues> createState() => _IssuesState();
}

class _IssuesState extends State<Issues> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      appBar: CustomAppBar(title: "Common Issues"),
      body: ListView(
        children: List.generate(issues.length, (index) {
          final item = issues[index];
          return CommonIssue(
            title: item.title,
            subTitle: item.subTitle,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (c) => IssueDatails(
                        title: item.title,
                        subTitle: item.subTitle,
                        discription: item.discription,
                        subDiscription: item.subDiscription,
                        subTreatment: item.subTreatment,
                        treatment: item.treatment,
                      ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
