import 'package:flutter/material.dart';
import 'dart:async';
import '../utils/AppTheme.dart';
import 'OnboardingScreens.dart'; // Import your onboarding screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate loading time then navigate
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor, // Orange background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Replace with your actual Logo Image if you have one, 
            // otherwise using a temporary Icon/Text to match design
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.restaurant_menu_rounded, // Placeholder for Chop-Chop logo
                color: AppTheme.primaryColor,
                size: 50,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "CHOP-CHOP",
              style: TextStyle(
                fontFamily: AppTheme.primaryFontFamily, // DM Sans
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}