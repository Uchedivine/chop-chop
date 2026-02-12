import 'package:flutter/material.dart';
import 'dart:math';

class OrderSuccessViewModel extends ChangeNotifier {
  String _orderNumber = "";
  String _estimatedTime = "";

  String get orderNumber => _orderNumber;
  String get estimatedTime => _estimatedTime;

  void generateOrderDetails() {
    // Mocking an order number and delivery time
    _orderNumber = (Random().nextInt(9000000000) + 1000000000).toString();
    _estimatedTime = "11:14pm, 24th September 2025"; // In a real app, this would be dynamic
    notifyListeners();
  }
}