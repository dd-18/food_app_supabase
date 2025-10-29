import 'package:flutter/material.dart';
import 'package:food_app_supabase/pages/Screens/app_main_screen.dart';
import 'package:food_app_supabase/pages/Screens/onboarding_screen.dart';
import 'package:food_app_supabase/pages/auth/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'pages/Screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://mdzkqzqxivdclwbofpmn.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1kemtxenF4aXZkY2x3Ym9mcG1uIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjE1NzAzMjcsImV4cCI6MjA3NzE0NjMyN30.hrEvjkd3GPj07ka43nTVrTrAIpgo1ppqYcHsf8GeBNE",
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: AuthCheck());
  }
}

class AuthCheck extends StatelessWidget {
  final supabase = Supabase.instance.client;
  AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = supabase.auth.currentSession;
        if (session != null) {
          return AppMainScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
