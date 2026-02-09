import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  // Banners
  final List<String> banners = [
    "assets/images/pizza_ad.png",
    "assets/images/burger_ad.png",
  ];

  // Categories
  final List<Map<String, String>> categories = [
    {'name': 'Local Dishes', 'icon': 'assets/images/local_dishes.png'},
    {'name': 'Continental', 'icon': 'assets/images/continental_meals.png'},
    {'name': 'Grills', 'icon': 'assets/images/grills_bbq.png'},
    {'name': 'Quick Bites', 'icon': 'assets/images/quick_bites.png'},
    {'name': 'Drinks', 'icon': 'assets/images/drinks_refreshments.png'},
  ];

  // Popular Restaurants
  final List<Map<String, dynamic>> restaurants = [
    {
      'name': 'Chicken Republic',
      'image': 'assets/images/chicken_rep.png',
      'time': '15 - 20 mins',
      'rating': '4.5',
      'price': 'N1,000'
    },
    {
      'name': 'Burger King',
      'image': 'assets/images/burger_king.png',
      'time': '10 - 15 mins',
      'rating': '5.0',
      'price': 'N800'
    },
  ];
}