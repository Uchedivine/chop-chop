import 'package:flutter/material.dart';

class FavoritesViewModel extends ChangeNotifier {
  final List<Map<String, dynamic>> _favoriteRestaurants = [];

  List<Map<String, dynamic>> get favoriteRestaurants => _favoriteRestaurants;

  bool isFavorite(Map<String, dynamic> restaurant) {
    return _favoriteRestaurants.any((r) => r['name'] == restaurant['name']);
  }

  void toggleFavorite(Map<String, dynamic> restaurant) {
    final index =
        _favoriteRestaurants.indexWhere((r) => r['name'] == restaurant['name']);
    if (index != -1) {
      _favoriteRestaurants.removeAt(index);
    } else {
      // Create a copy to ensure any local state changes don't affect the original if it was shared
      _favoriteRestaurants.add(Map<String, dynamic>.from(restaurant));
    }
    notifyListeners();
  }
}
