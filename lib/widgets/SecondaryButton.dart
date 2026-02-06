import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color textColor;

  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor = Colors.orange, // Default to your theme orange
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Matches the PrimaryButton width
      height: 55,            // Standard height for 1:1 fidelity
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Consistent radius
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}