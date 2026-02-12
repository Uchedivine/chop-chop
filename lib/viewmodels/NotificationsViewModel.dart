import 'package:flutter/material.dart';

class NotificationModel {
  final String title;
  final String time;
  final String message;
  final String status; // 'canceled', 'delivered', 'on-way', 'received', 'success'
  final bool isNew;
  final String? actionLabel;

  NotificationModel({
    required this.title, 
    required this.time, 
    required this.message, 
    required this.status, 
    this.isNew = false, 
    this.actionLabel
  });
}

class NotificationsViewModel extends ChangeNotifier {
  int _selectedTabIndex = 0;
  int get selectedTabIndex => _selectedTabIndex;

  final List<NotificationModel> _orderUpdates = [
    NotificationModel(
      title: "Order Canceled",
      time: "16 minutes ago",
      message: "You have canceled your order of three items from Mama Good's Kitchen on the 29th of October by 4:30 pm.",
      status: 'canceled',
      isNew: true,
    ),
    NotificationModel(
      title: "Confirm! Your order don land!",
      time: "24th October 2025 | 8:05 pm",
      message: "Your order of Four items from Tasty Fingers has been confirmed to be recieved on the 24th of october by 8:05 pm.",
      status: 'delivered',
      actionLabel: "Rate and leave a review",
    ),
    NotificationModel(
      title: "Your Order dey come",
      time: "24th October 2025 | 7:55 pm",
      message: "Your order has been successfully put together by Tasty Fingers and is on it's way!",
      status: 'on-way',
      actionLabel: "Track Order",
    ),
    NotificationModel(
      title: "Them don recieve your Order",
      time: "24th October 2025 | 7:45 pm",
      message: "Your order has been recieved by Tasty Fingers and is being put together.",
      status: 'received',
    ),
    NotificationModel(
      title: "Order Successful",
      time: "24th October 2025 | 7:42 pm",
      message: "Congratulations, your order number 22175643 to Tasty Fingers is successful.",
      status: 'success',
    ),
  ];

  List<NotificationModel> get notifications => _selectedTabIndex == 0 ? _orderUpdates : [];

  void setTabIndex(int index) {
    _selectedTabIndex = index;
    notifyListeners();
  }
}