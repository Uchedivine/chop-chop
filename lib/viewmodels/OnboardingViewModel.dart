import 'package:flutter/material.dart';
import '../models/OnboardingModel.dart';
import 'package:chop_chop/routes/AppRoutes.dart';

class OnboardingViewModel extends ChangeNotifier {
  final PageController pageController = PageController();
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  // Data moved to a private list to encapsulate it
  final List<OnboardingModel> _pages = [
    OnboardingModel(
      image: 'assets/images/onboardings1.png',
      title: 'Discover Local Flavors\nYou Love',
      description: 'From your favorite street food spots to hidden gems, explore authentic local dishes, all in one app.',
    ),
    OnboardingModel(
      image: 'assets/images/onboardings2.png',
      title: 'Count on Fast\nDeliveries, Everytime!',
      description: 'Your food moves as fast as your cravings, hot and right on time!',
    ),
    OnboardingModel(
      image: 'assets/images/onboardings3.png',
      title: 'Protected from\nKitchen To Doorstep',
      description: 'Every step of your order is monitored to keep your experience clean and secure.',
    ),
  ];

  List<OnboardingModel> get pages => _pages;

  void onPageChanged(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void next(BuildContext context) {
    if (_currentIndex < _pages.length - 1) {
      // Logic to move to the next slide
      if (pageController.hasClients) {
        pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    } else {
      // If we are on the last page, pressing "Next" or "Get Started" 
      // should trigger completion
      completeOnboarding(context);
    }
  }

  void completeOnboarding(BuildContext context) {
    // Navigate to Login using the named route we defined
    // We use navigateToReplacement so the user can't go back to onboarding
    AppRoutes.navigateToReplacement(context, AppRoutes.login);
  }

  @override
  void dispose() {
    // Crucial for MVVM: Clean up the controller when the ViewModel is destroyed
    pageController.dispose();
    super.dispose();
  }
}