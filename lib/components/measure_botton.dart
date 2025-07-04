import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/core/colors.dart';

class MeasureBotton extends StatefulWidget {
  @override
  _MeasureBottonState createState() => _MeasureBottonState();
}

class _MeasureBottonState extends State<MeasureBotton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Container(
        // width: 250,
        // height: 250,
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF5B8FE5), Color(0xFF5B8FE5), Color(0xFF5B8FE5)],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(10),
          // borderRadius: BorderRadius.circular(500),
        ),
        child: Center(
          child: Text(
            "Measure Your Glucose",
            // "Measure \nYour Glucose",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20,
              // fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
