import 'package:flutter/cupertino.dart';
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

    return TextFormField(
      controller: controller,
      cursorColor: Colors.black,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9 ]')),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please fill this field to proceed.";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: isLight ? Color.fromARGB(255, 73, 73, 73) : Color(0xffF2F2F2),
        ),
        prefixIcon: Icon(icon, color: Colors.grey[700]),
        filled: true,
        fillColor:
            isLight ? Color(0xffF2F2F2) : Color.fromARGB(255, 73, 73, 73),
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

    return TextFormField(
      controller: controller,
      cursorColor: AppColors.primary,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please fill this field to proceed.";
        }
        return null;
      },
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

    return TextFormField(
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
        fillColor:
            isLight ? Color(0xffF2F2F2) : Color.fromARGB(255, 73, 73, 73),
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

    return TextFormField(
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
        fillColor:
            isLight ? Color(0xffF2F2F2) : Color.fromARGB(255, 73, 73, 73),
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

    return TextFormField(
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
        fillColor:
            isLight ? Color(0xffF2F2F2) : Color.fromARGB(255, 73, 73, 73),
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

class PasswordTextField extends StatefulWidget {
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
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    bool isLight = Provider.of<ChangeThemeProvider>(context).isLight;

    return TextFormField(
      obscureText: !showPassword,
      controller: widget.controller,
      cursorColor: Colors.black,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please fill this field to proceed.";
        }
        if (value.contains(" ")) {
          return "Can't contain spaces.";
        }
        if (value.length < 8) {
          return "Short password.";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(
          color: isLight ? Color.fromARGB(255, 73, 73, 73) : Color(0xffF2F2F2),
        ),
        suffix: GestureDetector(
          onTap:
              () => setState(() {
                showPassword = !showPassword;
              }),
          child: Icon(
            showPassword ? Icons.visibility_off : Icons.visibility,
            size: 17,
            color: Colors.grey[600],
          ),
        ),
        prefixIcon: Icon(widget.icon, color: Colors.grey[700]),
        filled: true,
        fillColor:
            isLight ? Color(0xffF2F2F2) : Color.fromARGB(255, 73, 73, 73),
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

    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-z0-9@._-]')),
      ],
      cursorColor: Colors.black,
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please fill this field to proceed.";
        }
        if (!value.endsWith("@gmail.com")) {
          return "Invalid Email format.";
        }
        if (value.contains(" ")) {
          return "Can't contain spaces.";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: isLight ? Color.fromARGB(255, 73, 73, 73) : Color(0xffF2F2F2),
        ),
        prefixIcon: Icon(icon, color: Colors.grey[700]),
        filled: true,
        fillColor:
            isLight ? Color(0xffF2F2F2) : Color.fromARGB(255, 73, 73, 73),
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
