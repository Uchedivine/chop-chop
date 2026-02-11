import 'package:flutter/material.dart';
import '../models/MenuItem.dart';
import '../viewmodels/CartViewModel.dart';
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
import '../views/RestaurantDetailsScreen.dart';
import '../views/FoodDetailsScreen.dart';
import '../views/CartScreen.dart'; 
import '../views/OrderSummaryScreen.dart';

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
  static const String restaurantDetails = '/restaurant-details';
  static const String foodDetailsRoute = '/food-details';
  static const String cart = '/cart';
  static const String orderSummary = '/order-summary';

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
      restaurantDetails: (context) => const RestaurantDetailsScreen(),
      
      // FIX 1: Access arguments without using a named parameter 'item' 
      // if FoodDetailsScreen doesn't define it in its constructor.
      foodDetailsRoute: (context) => const FoodDetailsScreen(),
      
      cart: (context) => const CartScreen(),
      
      // FIX 2: Correctly extracting required named parameters for OrderSummaryScreen
      orderSummary: (context) {
        final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

        return OrderSummaryScreen(
          restaurantName: args?['restaurantName'] ?? "Unknown Restaurant",
          restaurantItems: args?['restaurantItems'] ?? <CartItem>[],
        );
      },
    };
  }

  // --- Navigation Helpers ---

  static void navigateTo(BuildContext context, String routeName, {Object? arguments}) {
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

  static void navigateToFoodDetails(BuildContext context, MenuItem item) {
    navigateTo(context, foodDetailsRoute, arguments: item);
  }

  static void navigateToOrderSummary(BuildContext context, String name, List<CartItem> items) {
    navigateTo(
      context, 
      orderSummary, 
      arguments: {
        'restaurantName': name,
        'restaurantItems': items,
      },
    );
  }
}