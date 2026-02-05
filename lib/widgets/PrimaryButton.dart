import 'package:flutter/material.dart';

/// Reusable Primary Button Widget
/// This is the solid orange button used throughout the app
/// 
/// Usage Example:
/// ```dart
/// PrimaryButton(
///   text: "Get Started",
///   onPressed: () {
///     // Do something
///   },
/// )
/// ```
class PrimaryButton extends StatelessWidget {
  // STEP 1: Define the properties this widget needs
  final String text;              // The button text
  final VoidCallback onPressed;   // The function to run when pressed
  final bool isLoading;           // Whether to show loading spinner
  final double? width;            // Optional width (null = full width)
  final double height;            // Button height

  // STEP 2: Constructor - this is how we pass data to the widget
  const PrimaryButton({
    super.key,
    required this.text,        // Required: must provide text
    required this.onPressed,   // Required: must provide onPressed
    this.isLoading = false,    // Optional: defaults to false
    this.width,                // Optional: defaults to null (full width)
    this.height = 56,          // Optional: defaults to 56
  });

  // STEP 3: Build method - this creates the actual UI
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,  // If width is null, use full width
      height: height,
      child: ElevatedButton(
        // Disable button if loading
        onPressed: isLoading ? null : onPressed,
        
        // STEP 4: Button styling - all the design specs
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF66C09),  // Orange from style guide
          foregroundColor: Colors.white,              // White text
          disabledBackgroundColor: const Color(0xFFF66C09).withOpacity(0.6),
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),  // Rounded corners
          ),
        ),
        
        // STEP 5: Button child - either loading spinner or text
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
      ),
    );
  }
}