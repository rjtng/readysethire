import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Friendly, light color palette based on new designs
  static const Color primaryColor = Color(0xFFD185A6); // Muted Pink from buttons
  static const Color secondaryColor = Color(0xFF491D7F); // Purple from text

  // User-defined colors
  static const Color fontColor = Color(0xFF491D7F); // Dark Purple for text and icons
  static const Color navBarColor = Color(0xFFFFFFFF); // White Nav Bar

  // Gradient background colors from user - UPDATED
  static const Color backgroundStart = Color(0xFFDDC4E4);
  static const Color backgroundEnd = Color(0xFFFFF0F2);

  // Card color for light theme
  static const Color cardColor = Colors.white;

  static ThemeData get theme {
    return ThemeData(
      scaffoldBackgroundColor:
      Colors.transparent, // Important for gradient background
      primaryColor: primaryColor,
      fontFamily: GoogleFonts.b612Mono().fontFamily, // NEW Font
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: fontColor), // Use dark font color
        titleTextStyle: TextStyle(
            color: fontColor, fontSize: 22, fontWeight: FontWeight.bold),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
            color: fontColor,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.b612Mono().fontFamily),
        // ADDED: headlineSmall for 'Choose Your Tools'
        headlineSmall: TextStyle(
            color: fontColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.b612Mono().fontFamily),
        titleLarge: TextStyle(
            color: fontColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.b612Mono().fontFamily),
        // ADDED: titleSmall for card titles
        titleSmall: TextStyle(
            color: fontColor,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.b612Mono().fontFamily),
        bodyLarge: TextStyle(
            color: fontColor,
            fontSize: 16,
            fontFamily: GoogleFonts.b612Mono().fontFamily),
        bodyMedium: TextStyle(
            color: fontColor,
            fontSize: 14,
            fontFamily: GoogleFonts.b612Mono().fontFamily),
        labelLarge: TextStyle(
            color: fontColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.b612Mono().fontFamily), // For solid buttons
      ),
      iconTheme:
      const IconThemeData(color: fontColor), // Set default icon color
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white, // Solid white
        contentPadding:
        const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        hintStyle: TextStyle(color: fontColor.withOpacity(0.6)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 18),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: navBarColor, // NEW Nav Bar Color
        selectedItemColor: primaryColor,
        unselectedItemColor: fontColor.withOpacity(0.6),
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false, // Icons only
      ),
    );
  }
}
