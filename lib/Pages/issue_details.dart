import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/Tools/colors.dart';
import 'package:grad_project/Tools/functions.dart';

class IssueDatails extends StatefulWidget {
  final String title,
      subTitle,
      discription,
      subDiscription,
      treatment,
      subTreatment;

  const IssueDatails({
    super.key,
    required this.title,
    required this.subTitle,
    required this.discription,
    required this.subDiscription,
    required this.subTreatment,
    required this.treatment,
  });

  @override
  State<IssueDatails> createState() => _IssueDatailsState();
}

class _IssueDatailsState extends State<IssueDatails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Issue Details"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Title:",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300, width: 1.5),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(3, 3),
                  ),
                ],
              ),
              child: ListTile(
                title: Text(
                  widget.title,
                  style: GoogleFonts.poppins(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                subtitle: Text(
                  textAlign: TextAlign.right,
                  widget.subTitle,
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.black26,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Description:",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300, width: 1.5),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(3, 3),
                  ),
                ],
              ),
              child: ListTile(
                title: Text(
                  widget.discription,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.logo,
                  ),
                ),
                subtitle: Text(
                  textAlign: TextAlign.right,
                  widget.subDiscription,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.black26,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Treatment:",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300, width: 1.5),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(3, 3),
                  ),
                ],
              ),
              child: ListTile(
                title: Text(
                  widget.treatment,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.logo,
                  ),
                ),
                subtitle: Text(
                  textAlign: TextAlign.right,
                  widget.subTreatment,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.black26,
              ),
            ),
            Gap(10),
            botton("Back", () {
              Navigator.pop(context);
            }),
            Gap(20),
          ],
        ),
      ),
    );
  }
}
