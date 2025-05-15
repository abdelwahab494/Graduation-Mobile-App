import 'package:flutter/material.dart';
import 'package:grad_project/Tools/functions.dart';
import 'package:grad_project/auth/auth_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // get auth service
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    // get user email
    final currentEmail = authService.getCurrentItem("email");
    final currentusername = authService.getCurrentItem("name");
    final currentid = authService.getCurrentId();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(currentEmail),
            Text(currentusername),
            Text(currentid!),
          ],
        ),
      ),
      floatingActionButton: ChatBotton(),
    );
  }
}
