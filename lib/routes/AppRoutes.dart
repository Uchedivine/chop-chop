import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/MenuItem.dart';
import '../viewmodels/CartViewModel.dart';
import '../viewmodels/CheckoutViewModel.dart';
import '../viewmodels/OrderSuccessViewModel.dart';
import '../viewmodels/TrackOrderViewModel.dart'; // Added
import '../views/SplashScreen.dart';
import '../views/OnboardingScreens.dart';
import '../views/LanguageSelectionScreen.dart';
import '../views/LoginScreen.dart';
import '../views/OTPScreen.dart';
import '../views/LocationMapScreen.dart';
import '../views/AddressDetailsScreen.dart';
import '../views/SupportScreen.dart';
import '../views/FoodPreferenceScreen.dart';
import '../views/RestaurantPreferenceScreen.dart';
import '../views/HomeScreen.dart';
import '../views/SearchScreen.dart';
import '../views/NotificationsScreen.dart';
import '../views/RestaurantDetailsScreen.dart';
import '../views/FoodDetailsScreen.dart';
import '../views/CartScreen.dart';
import '../views/OrderSummaryScreen.dart';
import '../views/CheckoutScreen.dart';
import '../views/PaymentMethodsScreen.dart';
import '../views/OrderSuccessScreen.dart';
import '../views/TrackOrderScreen.dart'; // Added

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
  static const String checkout = '/checkout';
  static const String paymentMethods = '/payment-methods';
  static const String orderSuccess = '/order-success';
  static const String trackOrder = '/track-order'; // Added
  static const String support = '/support';

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
      foodDetailsRoute: (context) => const FoodDetailsScreen(),
      cart: (context) => const CartScreen(),

      orderSummary: (context) {
        final args =
            ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
        return OrderSummaryScreen(
          restaurantName: args?['restaurantName'] ?? "Unknown Restaurant",
          restaurantItems: args?['restaurantItems'] ?? <CartItem>[],
        );
      },

      checkout: (context) {
        final args =
            ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
        return ChangeNotifierProvider(
          create: (_) => CheckoutViewModel(),
          child: CheckoutScreen(
            restaurantName: args?['restaurantName'] ?? "Unknown",
            subtotal: args?['subtotal'] ?? 0.0,
            deliveryAddress: args?['deliveryAddress'],
          ),
        );
      },

      paymentMethods: (context) {
        final currentMethod =
            ModalRoute.of(context)?.settings.arguments as String? ??
                "Credit/Debit Card";
        return PaymentMethodsScreen(currentMethod: currentMethod);
      },

      orderSuccess: (context) {
        final args =
            ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
        return ChangeNotifierProvider(
          create: (_) => OrderSuccessViewModel(),
          child: OrderSuccessScreen(
            restaurantName: args['restaurantName'],
            totalExpense: args['totalExpense'],
            deliveryAddress: args['deliveryAddress'],
          ),
        );
      },

      // Added Track Order Route
      trackOrder: (context) {
        final args =
            ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
        return ChangeNotifierProvider(
          create: (_) => TrackOrderViewModel(),
          child: TrackOrderScreen(
            deliveryAddress: args['deliveryAddress'],
            estimatedTime: args['estimatedTime'],
          ),
        );
      },
      register: (context) => const SearchScreen(),
      support: (context) => const SupportScreen(),
    };
  }

  // --- Navigation Helpers ---

  static void navigateTo(BuildContext context, String routeName,
      {Object? arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static Future<dynamic> navigateToPaymentMethods(
      BuildContext context, String currentMethod) {
    return Navigator.pushNamed(context, paymentMethods,
        arguments: currentMethod);
  }

  static void navigateToOrderSuccess(
      BuildContext context, String name, String total, String address) {
    navigateTo(context, orderSuccess, arguments: {
      'restaurantName': name,
      'totalExpense': total,
      'deliveryAddress': address,
    });
  }

  // Added Track Order Helper
  static void navigateToTrackOrder(
      BuildContext context, String address, String time) {
    navigateTo(context, trackOrder, arguments: {
      'deliveryAddress': address,
      'estimatedTime': time,
    });
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

  static void navigateToOrderSummary(
      BuildContext context, String name, List<CartItem> items) {
    navigateTo(context, orderSummary, arguments: {
      'restaurantName': name,
      'restaurantItems': items,
    });
  }

  static void navigateToCheckout(
      BuildContext context, String name, double total, String address) {
    navigateTo(context, checkout, arguments: {
      'restaurantName': name,
      'subtotal': total,
      'deliveryAddress': address,
    });
  }
}
