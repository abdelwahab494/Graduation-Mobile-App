import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:grad_project/Auth/auth_gate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  Gemini.init(apiKey: "AIzaSyD9k7u5umJGhZr0CIQ_1pNWn-oOqOsls3Y");
  await Supabase.initialize(
    anonKey:
        "",
    url: "",
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: AuthGate(),
    );
  }
}

