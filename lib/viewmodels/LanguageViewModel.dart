// lib/viewmodels/LanguageViewModel.dart
import 'package:flutter/material.dart';
import '../models/LanguageModel.dart';

class LanguageViewModel extends ChangeNotifier {
  int _selectedIndex = 0; // Default to English
  int get selectedIndex => _selectedIndex;

  final List<LanguageModel> languages = [
    LanguageModel(name: "English", code: "en"),
    LanguageModel(name: "Yoruba", code: "yo"),
    LanguageModel(name: "Igbo", code: "ig"),
    LanguageModel(name: "Hausa", code: "ha"),
    LanguageModel(name: "Pidgin English", code: "pcm"),
  ];

  void selectLanguage(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

void confirmSelection(BuildContext context) {
    // 1. Logic to save preference (Optional: Implement SharedPreferences here)
    debugPrint("Language confirmed: ${languages[_selectedIndex].name}");

    // 2. Navigate to Login Screen
    // We use navigateToReplacement so they can't "back" into the language selector
    //AppRoutes.navigateToReplacement(context, AppRoutes.login);
  }
}