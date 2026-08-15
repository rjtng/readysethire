import 'package:flutter/material.dart';
import 'package:readysethire/theme/app_theme.dart'; // Import AppTheme

class SolidButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double? width;  // <-- 1. ADD THIS
  final double? height; // <-- 2. ADD THIS


  const SolidButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = AppTheme.primaryColor,
    this.textColor = AppTheme.fontColor,
    this.width,  // <-- 3. ADD THIS
    this.height, // <-- 4. ADD THIS
  });

  @override
  Widget build(BuildContext context) {
    // 5. WRAP WITH SIZEDBOX
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

          // 6. THIS IS THE CRITICAL FIX
          // Remove hard-coded padding to allow the button to be 39px tall
          padding: EdgeInsets.zero, // <-- CHANGED from (vertical: 18)

          elevation: 2,
        ),
        child: Text(text,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: textColor)),
      ),
    );
  }
}