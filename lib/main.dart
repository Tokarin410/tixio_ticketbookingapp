import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tixio/homepage/home_screen.dart';
import 'package:tixio/taskbar_and_navbot/safety_instructions_screen.dart';
import 'package:tixio/taskbar_and_navbot/regulations_screen.dart';
import 'package:tixio/taskbar_and_navbot/report_incident_screen.dart';
import 'package:tixio/taskbar_and_navbot/notifications_screen.dart';
import 'package:tixio/wrapper.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyC9RFtMFK1b3aWZ0ymDsa5DvCdeJMiBMx4",
            authDomain: "tixio-eb7e5.firebaseapp.com",
            projectId: "tixio-eb7e5",
            storageBucket: "tixio-eb7e5.firebasestorage.app",
            messagingSenderId: "149609022354",
            appId: "1:149609022354:web:47f240c5c03c49a389774b",
            measurementId: "G-F5SRLP3QYY"));
  } else {
    await Firebase.initializeApp();
  }

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
      home: const Wrapper(),
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

