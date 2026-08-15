import 'package:flutter/material.dart';
import 'package:readysethire/theme/app_theme.dart'; // Import AppTheme

class LogoWidget extends StatelessWidget {
  final double size;
  const LogoWidget({super.key, this.size = 150});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://i.imgur.com/jStHkjp.png', // Corrected URL
      height: size,
      width: size,
      errorBuilder: (context, error, stackTrace) {
        return Icon(Icons.style, size: size, color: AppTheme.primaryColor);
      },
    );
  }
}
