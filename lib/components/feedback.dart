import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/components/custom_botton.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class FeedbackContainer extends StatefulWidget {
  const FeedbackContainer({
    super.key,
    required this.onTap,
    required this.controller,
    required this.provider,
    required this.onTap2,
    required this.cancel,
  });
  final onTap;
  final onTap2;
  final controller;
  final provider;
  final bool cancel;

  @override
  State<FeedbackContainer> createState() => _FeedbackContainerState();
}

class _FeedbackContainerState extends State<FeedbackContainer> {
  @override
  Widget build(BuildContext context) {
    final bool isLight = Provider.of<ChangeThemeProvider>(context).isLight;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: isLight ? Colors.grey.shade200 : Colors.grey.shade800,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Spacer(),
              Spacer(),
              Text(
                "Share Your Feedback",
                style: GoogleFonts.poppins(
                  color: AppColors.text,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              !widget.cancel ? SizedBox.shrink() : Spacer(),
              !widget.cancel
                  ? SizedBox.shrink()
                  : GestureDetector(
                    onTap: widget.onTap2,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Icon(CupertinoIcons.clear, color: Colors.grey),
                    ),
                  ),
            ],
          ),
          Gap(10),
          Text(
            "We value your input on the prediction results.",
            style: GoogleFonts.poppins(
              color: isLight ? Colors.grey.shade600 : Colors.grey.shade300,
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
                BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5),
              ],
            ),
            child: TextField(
              controller: widget.controller,
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
          CustomBotton(onTap: widget.onTap, text: "Submit Feedback"),
        ],
      ),
    );
  }
}
