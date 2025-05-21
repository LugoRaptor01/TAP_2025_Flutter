import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/DashboardScreen.dart';
import 'package:flutter_application_2/screens/challenge_screen.dart';
import 'package:flutter_application_2/screens/challenge_screen_main_manu.dart';
import 'package:flutter_application_2/screens/detailed_popular_movie.dart';
//import 'package:flutter_application_2/screens/contador_screen.dart';
import 'package:flutter_application_2/screens/login_screen.dart';
import 'package:flutter_application_2/screens/popular_screen.dart';
import 'package:flutter_application_2/utils/global_values.dart';
import 'package:flutter_application_2/utils/theme_setings.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: GlobalValues.themeMode,
      builder: (context, value, Widget) {
        return MaterialApp(
          theme: ThemeSettings.setTheme(value),
          home: const LoginScreen(),
          routes: {
            "/dash" : (context) => const DashboardScreen(),
            "/chall" : (context) => const ChallengeMainMenu(),
            "/api": (context) => const PopularScreen(),
            "/detail": (context) => const DetailedPopularMovie()
          },
          
        );
      }
    );
  }
}