import 'package:flutter/material.dart';

class CheckoutViewModel extends ChangeNotifier {
  // --- State Variables ---
  String _deliveryAddress = "";
  String _paymentMethod = "Debit/Credit Card";
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
  double get subtotal => _subtotal;       // ← was missing
  double get deliveryFee => _deliveryFee; // ← was missing
  double get totalAmount => (_subtotal + _deliveryFee + _tipAmount) - _discount;

  // --- Actions ---

  // Initialize with subtotal AND dynamic address from home screen
  void initialize(double passedSubtotal, String? passedAddress) {
    _subtotal = passedSubtotal;
    if (passedAddress != null && passedAddress.isNotEmpty) {
      _deliveryAddress = passedAddress;
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
    if (code.toUpperCase() == "CHOP100") {
      _discount = 100.0;
    } else {
      _discount = 0.0;
    }
    notifyListeners();
  }

  void updatePaymentMethod(String method) {
    _paymentMethod = method;
    notifyListeners();
  }
}