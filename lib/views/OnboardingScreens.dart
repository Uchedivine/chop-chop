import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/OnboardingViewModel.dart';
// STEP 1: Import our custom button widgets
import '../widgets/PrimaryButton.dart';
import '../widgets/OutlineButton.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingViewModel(),
      child: const _OnboardingScreenContent(),
    );
  }
}

class _OnboardingScreenContent extends StatelessWidget {
  const _OnboardingScreenContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<OnboardingViewModel>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF6ED),
      body: SafeArea(
        child: Column(
          children: [
            // PageView section (unchanged)
            Expanded(
              child: PageView.builder(
                controller: viewModel.pageController,
                onPageChanged: viewModel.onPageChanged,
                itemCount: viewModel.pages.length,
                itemBuilder: (context, index) {
                  final page = viewModel.pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 60),
                        
                        // Image
                        Image.asset(
                          page.image,
                          height: size.height * 0.32,
                          fit: BoxFit.contain,
                        ),
                        
                        const SizedBox(height: 50),
                        
                        // Title
                        Text(
                          page.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A1A),
                            height: 1.2,
                            fontFamily: 'DM Sans',
                          ),
                        ),
                        
                        const SizedBox(height: 12),
                        
                        // Description
                        Text(
                          page.description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                            height: 1.6,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            
            // Page Indicator (unchanged)
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  viewModel.pages.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    height: 4,
                    width: viewModel.currentIndex == index ? 32 : 16,
                    decoration: BoxDecoration(
                      color: viewModel.currentIndex == index
                          ? const Color(0xFFF66C09)
                          : const Color(0xFFFFD4B3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ),

            // STEP 2: Replace old button code with our widgets
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
              child: Column(
                children: [
                  // BEFORE: 20+ lines of button code
                  // AFTER: Just use PrimaryButton widget!
                  PrimaryButton(
                    text: viewModel.currentIndex == viewModel.pages.length - 1 
                        ? "Get Started" 
                        : "Get Started",
                    onPressed: () => viewModel.next(context),
                    // Optional: Add loading state
                    // isLoading: viewModel.isLoading,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // BEFORE: 20+ lines of outlined button code
                  // AFTER: Just use OutlineButton widget!
                  OutlineButton(
                    text: "Continue as Guest",
                    onPressed: () => viewModel.completeOnboarding(context),
                    // Optional: Add loading state
                    // isLoading: viewModel.isLoading,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}