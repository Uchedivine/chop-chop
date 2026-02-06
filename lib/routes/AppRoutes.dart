import 'package:flutter/material.dart';
import '../views/SplashScreen.dart';
import '../views/OnboardingScreens.dart';
import '../views/LanguageSelectionScreen.dart';
import '../views/LoginScreen.dart';
import '../views/OTPScreen.dart';
import '../views/LocationMapScreen.dart';
import '../views/AddressDetailsScreen.dart'; 

class AppRoutes {
  // Route names constants
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String languageSelection = '/language-selection';
  static const String login = '/login';
  static const String otp = '/otp';
  static const String locationMap = '/location-map';
  static const String addressDetails = '/address-details';
  static const String register = '/register';
  static const String home = '/home';

  // The Route Map used in main.dart
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashScreen(),
      onboarding: (context) => const OnboardingScreen(),
      languageSelection: (context) => const LanguageSelectionScreen(),
      login: (context) => const LoginScreen(),
      
      // Fixed: Arguments extraction for OTP
      otp: (context) {
        final args = ModalRoute.of(context)?.settings.arguments;
        // Cast safely: if it's not a string, provide a fallback to prevent crash
        final String destination = args is String ? args : "User"; 
        return OTPScreen(destination: destination);
      },

      locationMap: (context) => const LocationMapScreen(),
      addressDetails: (context) => const AddressDetailsScreen(),
      
      // Placeholder for future screens
      // register: (context) => const RegisterScreen(), 
      // home: (context) => const HomeScreen(),
    };
  }

  // --- Navigation Helpers ---

  /// Standard push navigation
  static void navigateTo(BuildContext context, String routeName, {Object? arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  /// Replacement navigation (e.g., Splash -> Onboarding)
  static void navigateToReplacement(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  /// Clear stack navigation (e.g., OTP Success -> Home)
  static void navigateToAndRemoveUntil(BuildContext context, String routeName) {
    Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
  }

  /// Specific helper for OTP to ensure argument type safety
  static void navigateToOtp(BuildContext context, String destination) {
    navigateTo(context, otp, arguments: destination);
  }
}