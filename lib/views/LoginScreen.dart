import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/LoginViewModel.dart';
import '../viewmodels/ThemeViewModel.dart';
import '../widgets/PrimaryButton.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controller to capture input for the ViewModel
  final TextEditingController _inputController = TextEditingController();

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginVM = Provider.of<LoginViewModel>(context);
    final themeVM = Provider.of<ThemeViewModel>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
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
      body: SingleChildScrollView(
        // Added scroll to prevent overflow on keyboard popup
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                loginVM.titleText,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: themeVM.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 32),

              // Input Field
             TextField(
  controller: _inputController,
  keyboardType: loginVM.selectedMethod == LoginMethod.phone 
      ? TextInputType.number 
      : TextInputType.emailAddress,
  style: TextStyle(color: themeVM.isDarkMode ? Colors.white : Colors.black),
  // Strict 11-digit enforcement
  inputFormatters: loginVM.selectedMethod == LoginMethod.phone 
      ? [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(11),
        ]
      : [],
  decoration: InputDecoration(
    hintText: loginVM.selectedMethod == LoginMethod.phone 
        ? "01234567899" // Example of the 11-digit format
        : "example@mail.com",
    // Adding the fixed prefix for phone mode
    prefixText: loginVM.selectedMethod == LoginMethod.phone ? "+234 " : null,
    prefixStyle: TextStyle(
      color: themeVM.isDarkMode ? Colors.white70 : Colors.black87,
      fontWeight: FontWeight.bold,
    ),
    errorText: loginVM.errorMessage,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
  ),
),
              const SizedBox(height: 24),

              PrimaryButton(
                text: "Continue",
                // Passing logic to ViewModel
                onPressed: () =>
                    loginVM.handleContinue(_inputController.text, context),
              ),

              const SizedBox(height: 32),
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text("Or continue with",
                        style: TextStyle(color: Colors.grey.shade600)),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 24),

              // Social Buttons
              _SocialButton(
                iconPath: 'assets/images/google_icon.png',
                label: "Google",
                isDark: themeVM.isDarkMode,
                onTap: () {},
              ),
              const SizedBox(height: 16),
              _SocialButton(
                icon: loginVM.toggleMethodIcon, // Dynamic icon
                label: loginVM
                    .toggleMethodLabel, // Switches between 'Email' and 'Phone Number'
                isDark: themeVM.isDarkMode,
                onTap: () {
                  _inputController.clear();
                  loginVM.toggleLoginMethod(); // Use the new toggle function
                },
              ),

              const SizedBox(height: 40),
              Center(
                child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    text:
                        "By clicking on continue you automatically agree with our ",
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    children: const [
                      TextSpan(
                        text: "Terms and Conditions",
                        style: TextStyle(
                            color: Colors.orange, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String? iconPath;
  final IconData? icon;
  final String label;
  final VoidCallback onTap;
  final bool isDark;

  const _SocialButton({
    this.iconPath,
    this.icon,
    required this.label,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: BorderSide(
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (iconPath != null) Image.asset(iconPath!, height: 24),
          if (icon != null)
            Icon(icon, color: isDark ? Colors.white : Colors.black),
          const SizedBox(width: 12),
          Text(label,
              style: TextStyle(
                  color: isDark ? Colors.white : Colors.black, fontSize: 16)),
        ],
      ),
    );
  }
}
