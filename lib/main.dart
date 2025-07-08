// import 'package:grad_project/noti_service.dart';
// import 'package:grad_project/providers/measure_provider.dart';
// import 'package:grad_project/providers/profile_image_provider.dart';
// import 'package:grad_project/providers/collect_info_provider.dart';
// import 'package:grad_project/providers/health_tips_provider.dart';
// import 'package:grad_project/providers/splash_provider.dart';
// import 'package:grad_project/providers/theme_provider.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:flutter_gemini/flutter_gemini.dart';
// import 'package:grad_project/auth/auth_gate.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter/material.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await NotiService().initNotification();
//   Gemini.init(apiKey: "AIzaSyD9k7u5umJGhZr0CIQ_1pNWn-oOqOsls3Y");
//   await Supabase.initialize(
//     anonKey:
//         "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InF5d2Nyb253em54bHF5b2JpYXhxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDcyNDQ1MjgsImV4cCI6MjA2MjgyMDUyOH0.b9YnN0ZvFOyPF7t5w0Fr9dsG7MAaUxoGA9ORUNb_wJk",
//     url: "https://qywcronwznxlqyobiaxq.supabase.co",
//   );
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => ProfileImageProvider()),
//         ChangeNotifierProvider(create: (_) => ChangeThemeProvider()),
//         ChangeNotifierProvider(create: (_) => SplashProvider()),
//         ChangeNotifierProvider(create: (_) => HealthTipsProvider()),
//         ChangeNotifierProvider(create: (_) => CollectInfoProvider()),
//         ChangeNotifierProvider(create: (_) => MeasureProvider()),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ChangeThemeProvider>(
//       builder: (context, theme, child) {
//         return MaterialApp(debugShowCheckedModeBanner: false, home: AuthGate());
//       },
//     );
//   }
// }

import 'package:grad_project/noti_service.dart';
import 'package:grad_project/providers/measure_provider.dart';
import 'package:grad_project/providers/profile_image_provider.dart';
import 'package:grad_project/providers/collect_info_provider.dart';
import 'package:grad_project/providers/health_tips_provider.dart';
import 'package:grad_project/providers/splash_provider.dart';
import 'package:grad_project/providers/theme_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:grad_project/auth/auth_gate.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart'; 
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  // تهيئة الإشعارات
  final notiService = NotiService();
  await notiService.initNotification();

  // طلب إذن الإشعارات
  await requestNotificationPermission();

  // تهيئة Gemini
  Gemini.init(apiKey: "");

  // تهيئة Supabase
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
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => HealthTipsProvider()),
        ChangeNotifierProvider(create: (_) => CollectInfoProvider()),
        ChangeNotifierProvider(create: (_) => MeasureProvider()),
        // Provider(create: (_) => NotificationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

// دالة طلب إذن الإشعارات
Future<void> requestNotificationPermission() async {
  final status = await Permission.notification.request();
  if (status.isDenied) {
    print('Notification permission denied');
  } else if (status.isPermanentlyDenied) {
    print('Notification permission permanently denied');
    await openAppSettings(); // فتح إعدادات التطبيق
  } else {
    print('Notification permission granted');
  }
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
