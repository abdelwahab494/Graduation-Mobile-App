import 'package:flutter/material.dart';
import 'package:grad_project/screens/issue_details.dart';
import 'package:grad_project/Tools/colors.dart';
import 'package:grad_project/Tools/functions.dart';
import 'package:grad_project/Tools/globals.dart';

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
      appBar: appBar("Common Issues", context),
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
