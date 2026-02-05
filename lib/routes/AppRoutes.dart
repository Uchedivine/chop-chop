import 'package:flutter/material.dart';
import '../views/SplashScreen.dart';
import '../views/OnboardingScreens.dart';

class AppRoutes {
  // Route names constants
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';

  // The Route Map
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashScreen(),
      onboarding: (context) => const OnboardingScreen(), 
      // login: (context) => const LoginScreen(),
      // home: (context) => const HomeScreen(),
    };
  }

  // Navigation Helpers (Static methods for cleaner UI code)
  
  // Use this for standard "Back button" navigation
  static void navigateTo(BuildContext context, String routeName, {Object? arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  // Use this when moving from Onboarding -> Login (removes onboarding from stack)
  static void navigateToReplacement(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  // Use this for Logout (clears all previous screens)
  static void navigateToAndRemoveUntil(BuildContext context, String routeName) {
    Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
  }
}