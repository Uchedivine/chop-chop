import 'dart:async';
import 'package:flutter/material.dart';

class OTPViewModel extends ChangeNotifier {
  // 5 Controllers for the 5-digit code boxes
  final List<TextEditingController> controllers = List.generate(5, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(5, (_) => FocusNode());
  
  int _timerSeconds = 60;
  int get timerSeconds => _timerSeconds;
  Timer? _timer;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  OTPViewModel() {
    startTimer();
  }

  void startTimer() {
    _timerSeconds = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        _timerSeconds--;
        notifyListeners();
      } else {
        _timer?.cancel();
      }
    });
  }

  Future<void> verifyCode(BuildContext context) async {
    String code = controllers.map((e) => e.text).join();
    if (code.length == 5) {
      _isLoading = true;
      notifyListeners();

      await Future.delayed(const Duration(seconds: 2));
      
      _isLoading = false;
      notifyListeners();
      
      debugPrint("Verified code: $code");
      // AppRoutes.navigateToAndRemoveUntil(context, AppRoutes.home);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var c in controllers) c.dispose();
    for (var n in focusNodes) n.dispose();
    super.dispose();
  }
}