import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.controller, required this.hint, required this.icon});
  final TextEditingController controller;
  final String hint;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: Icon(icon, color: Colors.grey[700]),
        filled: true,
        fillColor: Color(0xffF2F2F2),
        contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.transparent),
        ),
      ),
      style: TextStyle(color: Colors.black),
    );
  }
}