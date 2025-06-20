import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grad_project/Tools/colors.dart';
import 'package:grad_project/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
  });
  final TextEditingController controller;
  final String hint;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    bool isLight = Provider.of<ChangeThemeProvider>(context).isLight;

    return TextField(
      controller: controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: isLight ? Color.fromARGB(255, 73, 73, 73) : Color(0xffF2F2F2)),
        prefixIcon: Icon(icon, color: Colors.grey[700]),
        filled: true,
        fillColor: isLight ? Color(0xffF2F2F2) : Color.fromARGB(255, 73, 73, 73),
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
      style: TextStyle(color: AppColors.text),
    );
  }
}

class Customtextfield2 extends StatelessWidget {
  const Customtextfield2({
    super.key,
    required this.controller,
    required this.label,
  });
  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    bool isLight = Provider.of<ChangeThemeProvider>(context).isLight;

    return TextField(
      cursorColor: AppColors.primary,
      controller: controller,
      decoration: InputDecoration(
        label: Text(label),
        labelStyle: TextStyle(
          color: isLight ? Color.fromARGB(255, 73, 73, 73) : Color(0xffF2F2F2),
          fontSize: 14,
        ),
        filled: true,
        fillColor:
            isLight ? Color(0xffF2F2F2) : Color.fromARGB(255, 73, 73, 73),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.text),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 2.0),
        ),
      ),
    );
  }
}

class OnlyEngTextField extends StatelessWidget {
  const OnlyEngTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
  });
  final TextEditingController controller;
  final String hint;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    bool isLight = Provider.of<ChangeThemeProvider>(context).isLight;

    return TextField(
      keyboardType: TextInputType.text,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))],
      controller: controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: isLight ? Color.fromARGB(255, 73, 73, 73) : Color(0xffF2F2F2),
        ),
        prefixIcon: Icon(icon, color: Colors.grey[700]),
        filled: true,
        fillColor: isLight ? Color(0xffF2F2F2) : Color.fromARGB(255, 73, 73, 73),
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
      style: TextStyle(color: AppColors.text),
    );
  }
}

class OnlyArTextField extends StatelessWidget {
  const OnlyArTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
  });
  final TextEditingController controller;
  final String hint;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    bool isLight = Provider.of<ChangeThemeProvider>(context).isLight;

    return TextField(
      keyboardType: TextInputType.text,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[\u0600-\u06FF]')),
      ],
      cursorColor: Colors.black,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: isLight ? Color.fromARGB(255, 73, 73, 73) : Color(0xffF2F2F2),
        ),
        prefixIcon: Icon(icon, color: Colors.grey[700]),
        filled: true,
        fillColor: isLight ? Color(0xffF2F2F2) : Color.fromARGB(255, 73, 73, 73),
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
      style: TextStyle(color: AppColors.text),
    );
  }
}

class OnlyNumTextField extends StatelessWidget {
  const OnlyNumTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
  });
  final TextEditingController controller;
  final String hint;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    bool isLight = Provider.of<ChangeThemeProvider>(context).isLight;

    return TextField(
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      controller: controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: isLight ? Color.fromARGB(255, 73, 73, 73) : Color(0xffF2F2F2),
        ),
        prefixIcon: Icon(icon, color: Colors.grey[700]),
        filled: true,
        fillColor: isLight ? Color(0xffF2F2F2) : Color.fromARGB(255, 73, 73, 73),
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
      style: TextStyle(color: AppColors.text),
    );
  }
}

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
  });
  final TextEditingController controller;
  final String hint;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    bool isLight = Provider.of<ChangeThemeProvider>(context).isLight;

    return TextField(
      obscureText: true,
      controller: controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: isLight ? Color.fromARGB(255, 73, 73, 73) : Color(0xffF2F2F2)),
        prefixIcon: Icon(icon, color: Colors.grey[700]),
        filled: true,
        fillColor: isLight ? Color(0xffF2F2F2) : Color.fromARGB(255, 73, 73, 73),
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
      style: TextStyle(color: AppColors.text),
    );
  }
}

class OnlyEmailTextField extends StatelessWidget {
  const OnlyEmailTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
  });
  final TextEditingController controller;
  final String hint;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    bool isLight = Provider.of<ChangeThemeProvider>(context).isLight;

    return TextField(
      keyboardType: TextInputType.emailAddress,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._-]')),
      ],
      cursorColor: Colors.black,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: isLight ? Color.fromARGB(255, 73, 73, 73) : Color(0xffF2F2F2)),
        prefixIcon: Icon(icon, color: Colors.grey[700]),
        filled: true,
        fillColor: isLight ? Color(0xffF2F2F2) : Color.fromARGB(255, 73, 73, 73),
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
      style: TextStyle(color: AppColors.text),
    );
  }
}
