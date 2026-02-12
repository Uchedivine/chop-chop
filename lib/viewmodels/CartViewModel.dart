import 'package:flutter/material.dart';
import '../models/MenuItem.dart';

class CartItem {
  final MenuItem food;
  int quantity;
  final List<String> selectedOptions;

  CartItem({required this.food, this.quantity = 1, required this.selectedOptions});
}

class CartViewModel extends ChangeNotifier {
  final List<CartItem> _items = [];
  List<CartItem> get items => _items;

  void addToCart(MenuItem food, int quantity, List<String> options) {
    int index = _items.indexWhere((item) => item.food.name == food.name);
    
    if (index != -1) {
      _items[index].quantity += quantity;
    } else {
      _items.add(CartItem(food: food, quantity: quantity, selectedOptions: options));
    }
    notifyListeners();
  }

  void incrementQuantity(int index) {
    if (index >= 0 && index < _items.length) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity(int index) {
    if (index >= 0 && index < _items.length) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  // Clear everything
  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  // --- NEW: Clear only items from a specific restaurant ---
  void clearRestaurantFromCart(String restaurantName) {
    _items.removeWhere((item) => item.food.restaurantName == restaurantName);
    notifyListeners();
  }

  double get subtotal => _items.fold(0, (sum, item) {
    String priceString = item.food.price.replaceAll(RegExp(r'[^0-9]'), '');
    double price = double.tryParse(priceString) ?? 0.0;
    return sum + (price * item.quantity);
  });

  double get deliveryFee => _items.isEmpty ? 0.0 : 900.0;
  double get total => subtotal + deliveryFee;
}