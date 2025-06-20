import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:grad_project/Auth/auth_gate.dart';
import 'package:grad_project/providers/profile_image_provider.dart';
import 'package:grad_project/providers/signup_provider.dart';
import 'package:grad_project/providers/splash_provider.dart';
import 'package:grad_project/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  Gemini.init(apiKey: "AIzaSyD9k7u5umJGhZr0CIQ_1pNWn-oOqOsls3Y");
  await Supabase.initialize(
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InF5d2Nyb253em54bHF5b2JpYXhxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDcyNDQ1MjgsImV4cCI6MjA2MjgyMDUyOH0.b9YnN0ZvFOyPF7t5w0Fr9dsG7MAaUxoGA9ORUNb_wJk",
    url: "https://qywcronwznxlqyobiaxq.supabase.co",
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileImageProvider()),
        ChangeNotifierProvider(create: (_) => ChangeThemeProvider()),
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => SignupProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChangeThemeProvider>(
      builder: (context, theme, child) {
        return MaterialApp(debugShowCheckedModeBanner: false, home: AuthGate());
      },
    );
  }
}
