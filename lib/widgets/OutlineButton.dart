import 'package:flutter/material.dart';

/// Reusable Outline Button Widget
/// This is the bordered button with transparent background
/// 
/// Usage Example:
/// ```dart
/// OutlineButton(
///   text: "Continue as Guest",
///   onPressed: () {
///     // Do something
///   },
/// )
/// ```
class OutlineButton extends StatelessWidget {
  // STEP 1: Define properties
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final double? width;
  final double height;
  final Color? borderColor;    // Optional: custom border color
  final Color? textColor;      // Optional: custom text color

  // STEP 2: Constructor
  const OutlineButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.width,
    this.height = 56,
    this.borderColor,          // Defaults to orange if not provided
    this.textColor,            // Defaults to orange if not provided
  });

  // STEP 3: Build method
  @override
  Widget build(BuildContext context) {
    // Use provided colors or default to orange
    final Color finalBorderColor = borderColor ?? const Color(0xFFF66C09);
    final Color finalTextColor = textColor ?? const Color(0xFFF66C09);

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        
        // STEP 4: Button styling
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,  // No background
          foregroundColor: finalTextColor,
          disabledForegroundColor: finalTextColor.withOpacity(0.6),
          side: BorderSide(
            color: isLoading 
                ? finalBorderColor.withOpacity(0.6) 
                : finalBorderColor,
            width: 1.5,  // Border thickness
          ),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        
        // STEP 5: Button child
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(finalTextColor),
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                  color: finalTextColor,
                ),
              ),
      ),
    );
  }
}