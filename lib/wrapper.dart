import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tixio/homepage/home_screen.dart';
import 'package:tixio/login_and_register/onboarding/onboarding_screen.dart';
import 'package:tixio/services/authentication.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().user,
      builder: (context, snapshot) {
        
        // If snapshot has data, user is logged in
        if (snapshot.hasData) {
           return const HomeScreen();
        } 
        
        // If not logged in (or signing out), show Onboarding/Login
        else {
          return const OnboardingScreen();
        }
      },
    );
  }
}
