import 'package:flutter/material.dart';
import '../views/SplashScreen.dart';
import '../views/OnboardingScreens.dart';
import '../views/LanguageSelectionScreen.dart';
import '../views/LoginScreen.dart';
import '../views/OTPScreen.dart';
import '../views/LocationMapScreen.dart';
import '../views/AddressDetailsScreen.dart';
import '../views/FoodPreferenceScreen.dart';
import '../views/RestaurantPreferenceScreen.dart';
import '../views/HomeScreen.dart';
import '../views/SearchScreen.dart';
import '../views/NotificationsScreen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String languageSelection = '/language-selection';
  static const String login = '/login';
  static const String otp = '/otp';
  static const String locationMap = '/location-map';
  static const String addressDetails = '/address-details';
  static const String foodPreference = '/food-preference';
  static const String restaurantPreference = '/restaurant-preference';
  static const String register = '/register';
  static const String home = '/home';
  static const String searchRoute = '/search';
  static const String notifications = '/notifications';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashScreen(),
      onboarding: (context) => const OnboardingScreen(),
      languageSelection: (context) => const LanguageSelectionScreen(),
      login: (context) => const LoginScreen(),
      otp: (context) {
        final args = ModalRoute.of(context)?.settings.arguments;
        final String destination = args is String ? args : "User";
        return OTPScreen(destination: destination);
      },
      locationMap: (context) => const LocationMapScreen(),
      addressDetails: (context) => const AddressDetailsScreen(),
      foodPreference: (context) => const FoodPreferenceScreen(),
      restaurantPreference: (context) => const RestaurantPreferenceScreen(),
      home: (context) => const HomeScreen(),
      searchRoute: (context) => const SearchScreen(),
      notifications: (context) => const NotificationsScreen(),
    };
  }

  // --- Navigation Helpers ---

  static void navigateTo(BuildContext context, String routeName,
      {Object? arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static void navigateToReplacement(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  static void navigateToAndRemoveUntil(BuildContext context, String routeName) {
    Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
  }

  static void navigateToOtp(BuildContext context, String destination) {
    navigateTo(context, otp, arguments: destination);
  }
}
