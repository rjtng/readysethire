import 'package:flutter/material.dart';
import 'package:readysethire/theme/app_theme.dart'; // Import AppTheme

class StyledCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final bool isSelected;
  const StyledCard(
      {super.key, required this.child, this.onTap, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      color: AppTheme.cardColor,
      shadowColor: AppTheme.primaryColor.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: isSelected
            ? const BorderSide(color: AppTheme.primaryColor, width: 2)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.0),
        child: child,
      ),
    );
  }
}