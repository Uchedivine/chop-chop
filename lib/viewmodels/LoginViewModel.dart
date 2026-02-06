import 'package:flutter/material.dart';
import '../routes/AppRoutes.dart';

enum LoginMethod { phone, email }

class LoginViewModel extends ChangeNotifier {
  LoginMethod _selectedMethod = LoginMethod.phone;
  LoginMethod get selectedMethod => _selectedMethod;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Dynamic strings for the main header
  String get titleText => _selectedMethod == LoginMethod.phone
      ? "Enter Your Mobile Number"
      : "Enter Your Email Address";

  String get hintText => _selectedMethod == LoginMethod.phone
      ? "+234 *** *** ****"
      : "example@mail.com";

  // NEW: Dynamic strings for the toggle button
  String get toggleMethodLabel =>
      _selectedMethod == LoginMethod.phone ? "Email" : "Phone Number";

  IconData get toggleMethodIcon => _selectedMethod == LoginMethod.phone
      ? Icons.email_outlined
      : Icons.phone_android_outlined;

  // Updated: Centralized toggle logic
  void toggleLoginMethod() {
    if (_selectedMethod == LoginMethod.phone) {
      _selectedMethod = LoginMethod.email;
    } else {
      _selectedMethod = LoginMethod.phone;
    }
    _errorMessage = null; // Clear errors when switching
    notifyListeners();
  }

  bool validateInput(String input) {
    _errorMessage = null;

    if (input.isEmpty) {
      _errorMessage = "This field cannot be empty";
    } else if (_selectedMethod == LoginMethod.email) {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(input)) {
        _errorMessage = "Please enter a valid email address";
      }
    } else if (_selectedMethod == LoginMethod.phone) {
      //  Check for exactly 11 digits
      if (input.length != 11) {
        _errorMessage = "Phone number must be exactly 11 digits";
      } else if (!RegExp(r'^[0-9]+$').hasMatch(input)) {
        _errorMessage = "Please enter only numbers";
      }
    }

    notifyListeners();
    return _errorMessage == null;
  }

  Future<void> handleContinue(String input, BuildContext context) async {
    if (validateInput(input)) {
      _isLoading = true;
      notifyListeners();

      // Simulate a network delay for validation/API call
      await Future.delayed(const Duration(seconds: 2));

      _isLoading = false;
      notifyListeners();

      debugPrint("Proceeding with: $input");

      // Fix: Check if context is still mounted after async gap
      if (!context.mounted) return;

      AppRoutes.navigateToOtp(context, input);
    }
  }
}
