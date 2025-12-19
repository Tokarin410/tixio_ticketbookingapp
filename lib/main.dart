import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixio/login_and_register/onboarding/onboarding_screen.dart';
import 'package:tixio/homepage/home_screen.dart';
import 'package:tixio/taskbar_and_navbot/safety_instructions_screen.dart';
import 'package:tixio/taskbar_and_navbot/regulations_screen.dart';
import 'package:tixio/taskbar_and_navbot/report_incident_screen.dart';
import 'package:tixio/taskbar_and_navbot/notifications_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tixio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF013aad), // Primary Blue
          primary: const Color(0xFF013aad),
          secondary: const Color(0xFFb11d39), // Secondary Red
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.josefinSansTextTheme(),
      ),
      home: const OnboardingScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/safety_instructions': (context) => const SafetyInstructionsScreen(),
        '/regulations': (context) => const RegulationsScreen(),
        '/report_incident': (context) => const ReportIncidentScreen(),
        '/notifications': (context) => const NotificationsScreen(),
      },
    );
  }
}

