import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Define custom colors to be used throughout the app for easy maintenance.
class AppColors {
  static const Color background = Color(0xFFF8F9FA); // Light grey for the background
  static const Color surface = ;    // White for card surfaces
  static const Color primaryText = Color(0xFF212529); // Nearly black for primary text
  static const Color secondaryText = Color(0xFF6C757D); // Grey for secondary text
  static const Color success = Color(0xFF28A745);     // Green for positive balances/change
  static const Color warning = Color(0xFFDC3545);     // Red for negative/due change
  static const Color cardBorder = Color(0xFFDEE2E6);  // Light border color for cards
}

/// A class to hold the application's theme data.
/// This centralizes the app's styling, making it easy to change the look and feel.
class AppTheme {
  // Private constructor to prevent instantiation.
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    // Use Material 3 design principles.
    useMaterial3: true,

    // Define the overall color scheme of the app.
    colorScheme: const ColorScheme.light(
      surface: AppColors.surface,
      primary: AppColors.primaryText,
      secondary: AppColors.success,
      error: AppColors.warning,
      onSurface: AppColors.primaryText,
    ),

    // Set the default background color for scaffolds (app screens).
    scaffoldBackgroundColor: AppColors.background,

    // Define the default text styling using the Google Fonts package.
    // This ensures a consistent typography.
    textTheme: TextTheme(
      // For large, prominent text like the overall balance.
      displayMedium: GoogleFonts.lato(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: AppColors.success,
      ),
      // For titles, like names on the cards.
      headlineSmall: GoogleFonts.lato(
        fontSize: 24,
        fontWeight: FontWeight.w600, // Semi-bold
        color: AppColors.primaryText,
      ),
      // For body text, like "Owes:" and "Paid:".
      bodyLarge: GoogleFonts.lato(
        fontSize: 16,
        color: AppColors.secondaryText,
      ),
      // For specific, highlighted text like "Change Due".
      titleMedium: GoogleFonts.lato(
        fontSize: 18,
        fontWeight: FontWeight.w500, // Medium weight
      ),
    ),

    // // Define the default style for Card widgets.
    // cardTheme: CardTheme(
    //   color: AppColors.surface,
    //   elevation: 0, // No shadow for a flatter design, as seen in the image.
    //   margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(12.0),
    //     side: const BorderSide(
    //       color: AppColors.cardBorder,
    //       width: 1.5,
    //     ),
    //   ),
    // ),
  );
}
