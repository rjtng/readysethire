import 'package:flutter/material.dart';

// Centralized data models to be used by all guide screens.

class GuideContent {
  final String title;
  final String text;

  GuideContent({required this.title, required this.text});
}

class Guide {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<GuideContent> content;

  Guide(
      {required this.title,
        required this.subtitle,
        required this.icon,
        required this.content});
}
