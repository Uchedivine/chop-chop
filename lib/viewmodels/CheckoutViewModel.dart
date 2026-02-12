import 'package:flutter/material.dart';

class CheckoutViewModel extends ChangeNotifier {
  // --- Private State Variables ---
  String _deliveryAddress = "";
  String _paymentMethod = "Mastercard **** 4321"; // Initialized with a default card format
  String _voucherCode = "";
  double _tipAmount = 0.0;
  double _subtotal = 0.0;
  double _deliveryFee = 900.0;
  double _discount = 0.0;

  // --- Getters ---
  String get deliveryAddress => _deliveryAddress.isEmpty 
      ? "No delivery address set" 
      : _deliveryAddress;

  String get paymentMethod => _paymentMethod;
  double get tipAmount => _tipAmount;
  double get discount => _discount;
  double get subtotal => _subtotal;
  double get deliveryFee => _deliveryFee;
  
  // Dynamic calculation for the footer
  double get totalAmount => (_subtotal + _deliveryFee + _tipAmount) - _discount;

  // --- Actions ---

  /// Called when the Checkout screen is first opened to sync data from the Cart/Home
  void initialize(double passedSubtotal, String? passedAddress) {
    _subtotal = passedSubtotal;
    if (passedAddress != null && passedAddress.isNotEmpty) {
      _deliveryAddress = passedAddress;
    }
    notifyListeners();
  }

  /// Updates the payment method based on selection from PaymentMethodsScreen
  void updatePaymentMethod(String method) {
    // Logic to format the display name based on selection
    if (method == "Credit/Debit Card") {
      _paymentMethod = "Mastercard **** 4321";
    } else {
      _paymentMethod = method;
    }
    notifyListeners();
  }

  void updateDeliveryAddress(String address) {
    _deliveryAddress = address;
    notifyListeners();
  }

  void setTip(double amount) {
    _tipAmount = amount;
    notifyListeners();
  }

  void applyVoucher(String code) {
    _voucherCode = code;
    // Basic logic for promo code verification
    if (code.toUpperCase() == "CHOP100") {
      _discount = 100.0;
    } else if (code.toUpperCase() == "WELCOME500") {
      _discount = 500.0;
    } else {
      _discount = 0.0;
    }
    notifyListeners();
  }
}