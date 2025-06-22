import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/core/colors.dart';

class HealthArticales extends StatefulWidget {
  const HealthArticales({super.key, required this.articales});
  final articales;

  @override
  State<HealthArticales> createState() => _HealthArticalsState();
}

class _HealthArticalsState extends State<HealthArticales> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Health articles",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "See all",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.articales.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.all(6),
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        "assets/images/articale${widget.articales[index].image}.png",
                        width: 55,
                        fit: BoxFit.cover,
                      ),
                      Gap(10),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.articales[index].title,
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              widget.articales[index].subTitle,
                              style: GoogleFonts.poppins(
                                fontSize: 8,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(5),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.articales[index].isSaved =
                                !widget.articales[index].isSaved;
                          });
                        },
                        child: Icon(
                          widget.articales[index].isSaved
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color:
                              widget.articales[index].isSaved
                                  ? AppColors.primary
                                  : Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
