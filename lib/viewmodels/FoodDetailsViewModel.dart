import 'package:flutter/material.dart';
import '../models/MenuItem.dart';

class FoodDetailsViewModel extends ChangeNotifier {
  int _quantity = 1;
  int get quantity => _quantity;

  // Track selected options (using a set for multiple selections)
  final Set<String> _selectedOptions = {};
  Set<String> get selectedOptions => _selectedOptions;

  void increment() {
    _quantity++;
    notifyListeners();
  }

  void decrement() {
    if (_quantity > 1) {
      _quantity--;
      notifyListeners();
    }
  }

  void toggleOption(String optionName) {
    if (_selectedOptions.contains(optionName)) {
      _selectedOptions.remove(optionName);
    } else {
      _selectedOptions.add(optionName);
    }
    notifyListeners();
  }

  // Helper to calculate total (Simplified for now)
  String calculateTotal(String basePrice) {
    int price = int.parse(basePrice.replaceAll(RegExp(r'[^0-9]'), ''));
    // Add logic for option prices if they were in the model
    return "₦${(price * _quantity).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}";
  }
}