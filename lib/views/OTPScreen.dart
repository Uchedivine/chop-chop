import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/OTPViewModel.dart';
import '../viewmodels/ThemeViewModel.dart';
import '../widgets/PrimaryButton.dart';

class OTPScreen extends StatelessWidget {
  final String destination;
  const OTPScreen({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    final themeVM = Provider.of<ThemeViewModel>(context);
    final otpVM = Provider.of<OTPViewModel>(context);

    return Scaffold(
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor, // Tally to theme
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: themeVM.isDarkMode ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          // Theme Switcher
          IconButton(
            icon: Icon(
              themeVM.isDarkMode
                  ? Icons.nightlight_round
                  : Icons.wb_sunny_outlined,
              color: themeVM.isDarkMode ? Colors.white : Colors.orange,
            ),
            onPressed: () => themeVM.toggleTheme(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text("Enter Code",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text("We have sent a 5-digit code to",
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 12),
            Text(destination,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 48),

            // The 5 Discrete Boxes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                  5, (index) => _buildOtpBox(context, index, otpVM, themeVM)),
            ),

            const Spacer(),

            TextButton(
              onPressed: () {},
              child: const Text("Resend Code",
                  style: TextStyle(color: Color(0xFFF66C09), fontSize: 16)),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              text: "Enter Code",
              onPressed: () => otpVM.verifyCode(context),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpBox(BuildContext context, int index, OTPViewModel vm,
      ThemeViewModel themeVM) {
    return Container(
      width: 62,
      height: 62,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400, width: 1),
      ),
      child: TextField(
        controller: vm.controllers[index],
        focusNode: vm.focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: themeVM.isDarkMode ? Colors.white : Colors.black,
        ),
        decoration:
            const InputDecoration(counterText: "", border: InputBorder.none),
        onChanged: (value) {
          if (value.isNotEmpty && index < 4)
            vm.focusNodes[index + 1].requestFocus();
          if (value.isEmpty && index > 0)
            vm.focusNodes[index - 1].requestFocus();
        },
      ),
    );
  }
}
