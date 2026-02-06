import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/LanguageViewModel.dart';
import '../widgets/PrimaryButton.dart';
import '../viewmodels/ThemeViewModel.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LanguageViewModel>(context);
    // 1. Define the variable name
    final themeVM = Provider.of<ThemeViewModel>(context);

    return Scaffold(
      // 2. Use theme background so it switches automatically
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              // 3. FIX: Use 'themeVM' here, not 'themeViewModel'
              themeVM.isDarkMode ? Icons.nightlight_round : Icons.wb_sunny_outlined,
              color: themeVM.isDarkMode ? Colors.white : Colors.orange,
            ),
            onPressed: () {
              // 4. FIX: Use 'themeVM' here as well
              themeVM.toggleTheme();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Please Select A Language",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  // Use dynamic color for text (White in dark mode, Black in light)
                  color: themeVM.isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView.separated(
                  itemCount: viewModel.languages.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final isSelected = viewModel.selectedIndex == index;
                    return GestureDetector(
                      onTap: () => viewModel.selectLanguage(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                        decoration: BoxDecoration(
                          // Border color logic
                          border: Border.all(
                            color: isSelected 
                                ? const Color(0xFFF66C09) 
                                : (themeVM.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300),
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          // Optional: Add slight background color for dark mode items
                          color: themeVM.isDarkMode ? Colors.grey.shade900 : Colors.transparent,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              viewModel.languages[index].name,
                              style: TextStyle(
                                fontSize: 16,
                                // Text color logic
                                color: isSelected 
                                    ? (themeVM.isDarkMode ? Colors.white : Colors.black)
                                    : (themeVM.isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600),
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                            // Radio Indicator
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected ? const Color(0xFFF66C09) : Colors.grey.shade400,
                                  width: 2,
                                ),
                              ),
                              child: isSelected
                                  ? Center(
                                      child: Container(
                                        height: 10,
                                        width: 10,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFF66C09),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: PrimaryButton(
                  text: "Select",
                  onPressed: () { Navigator.pushNamed(context, '/login'); 
  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}