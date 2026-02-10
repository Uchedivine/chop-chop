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
      'name': '330 Eats',
      'image': 'assets/images/330eats.png',
      'time': '10 - 15 mins',
      'rating': '5.0',
      'price': '800'
    },
    {
      'name': 'Mega Chicken',
      'image': 'assets/images/mega_chicken.png',
      'time': '10 - 15 mins',
      'rating': '5.0',
      'price': '8000'
    },
    {
      'name': 'Prisca Sharwama',
      'image': 'assets/images/prisca_sharwama.png',
      'time': '10 - 15 mins',
      'rating': '5.0',
      'price': '3500'
    },
    {
      'name': 'Godbless Chicken & Chips',
      'image': 'assets/images/godbless_chicken_chips.png',
      'time': '10 - 15 mins',
      'rating': '5.0',
      'price': '800'
    },
    {
      'name': 'Chicken Republic',
      'image': 'assets/images/chicken_rep.png',
      'time': '15 - 20 mins',
      'rating': '4.5',
      'price': '1,000'
    },
    {
      'name': 'Burger King',
      'image': 'assets/images/burger_king.png',
      'time': '10 - 15 mins',
      'rating': '5.0',
      'price': '4000'
    },
   
  ];
}