import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:grad_project/Auth/auth_gate.dart';
import 'package:grad_project/Tools/colors.dart';
import 'package:grad_project/providers/profile_image_provider.dart';
import 'package:grad_project/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  Gemini.init(apiKey: "");
  await Supabase.initialize(
    anonKey:
        "",
    url: "",
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileImageProvider()),
        ChangeNotifierProvider(create: (_) => ChangeThemeProvider()),
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
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme.isLight ? lightTheme() : darkTheme(),
          home: AuthGate(),
        );
      },
    );
  }
}
