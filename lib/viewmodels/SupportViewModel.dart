import 'package:flutter/material.dart';

class SupportMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  SupportMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class SupportViewModel extends ChangeNotifier {
  final List<SupportMessage> _messages = [];
  List<SupportMessage> get messages => _messages;

  final List<String> _suggestions = [
    "How do I track my order?",
    "Suggest for me the best local dishes and restaurants around me",
    "How do I change the language settings for chop chop",
    "What restaurant has the best reviews?",
  ];
  List<String> get suggestions => _suggestions;

  final TextEditingController messageController = TextEditingController();

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    _messages.add(SupportMessage(
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    ));

    messageController.clear();
    notifyListeners();

    // Mock AI response
    Future.delayed(const Duration(seconds: 1), () {
      _messages.add(SupportMessage(
        text:
            "Thanks for your question! We're here to help. Our A.I. is currently learning, but we'll get back to you soon.",
        isUser: false,
        timestamp: DateTime.now(),
      ));
      notifyListeners();
    });
  }

  void onSuggestionTap(String suggestion) {
    sendMessage(suggestion);
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
