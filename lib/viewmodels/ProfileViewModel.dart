import 'package:flutter/material.dart';
import '../routes/AppRoutes.dart';

class ProfileViewModel extends ChangeNotifier {
  final String userName = "Emmanuel Isiguzo";
  final String userEmail = "emmanuelisigozo2002@gmail.com";
  final String userInitials = "EI";

  // List of profile menu items with their respective icons and routes
  final List<Map<String, dynamic>> menuItems = [
    {
      'title': 'Edit Profile',
      'icon': Icons.edit_outlined,
      'route': AppRoutes.editProfile,
    },
    {
      'title': 'Saved Addresses',
      'icon': Icons.location_on_outlined,
      'route': AppRoutes.addressDetails,
    },
    {
      'title': 'Orders',
      'icon': Icons.shopping_bag_outlined,
      'route': null, // Not yet implemented
    },
    {
      'title': 'Favorites',
      'icon': Icons.favorite_border,
      'route': AppRoutes.favorites,
    },
    {
      'title': 'Payment Methods',
      'icon': Icons.account_balance_wallet_outlined,
      'route': AppRoutes.paymentMethods,
    },
    {
      'title': 'Themes',
      'icon': Icons.wb_sunny_outlined,
      'route': AppRoutes.themes,
    },
    {
      'title': 'Languages',
      'icon': Icons.language_outlined,
      'route': AppRoutes.languageSelection,
    },
    {
      'title': 'Support',
      'icon': Icons.chat_bubble_outline,
      'route': AppRoutes.support,
    },
    {
      'title': 'FAQs',
      'icon': Icons.help_outline,
      'route': AppRoutes.faqs,
    },
  ];

  void handleItemTap(BuildContext context, Map<String, dynamic> item) {
    final route = item['route'];
    if (route != null) {
      if (route == AppRoutes.paymentMethods) {
        AppRoutes.navigateToPaymentMethods(context, "Credit/Debit Card");
      } else {
        Navigator.pushNamed(context, route);
      }
    } else {
      // Handle unimplemented routes or specific logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${item['title']} coming soon!")),
      );
    }
  }
}
