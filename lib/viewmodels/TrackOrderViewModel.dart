import 'package:flutter/material.dart';

enum OrderStatus { confirmed, received, onTheWay, delivered }

class TrackOrderViewModel extends ChangeNotifier {
  // Mock Driver Data
  final String driverName = "Okechi Maduaburuchukwu";
  final double driverRating = 4.8;
  final int totalReviews = 113;
  final String driverImage = "assets/images/driver.jpeg"; // Ensure this exists

  // Mock Status
  OrderStatus _currentStatus = OrderStatus.confirmed;
  OrderStatus get currentStatus => _currentStatus;

  // In a real app, you'd use a Stream or Timer to update this
  void updateStatus(OrderStatus status) {
    _currentStatus = status;
    notifyListeners();
  }

  // Helpers to check status completion for the UI
  bool isStepCompleted(OrderStatus status) {
    return _currentStatus.index >= status.index;
  }
}