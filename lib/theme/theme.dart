import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ModernPurpleTheme {
  // Purple color palette
  static const Color _primaryPurple = Color(0xFF7C3AED); // Vibrant purple
  static const Color _secondaryPurple = Color(0xFFA855F7); // Lighter purple
  static const Color _accentPurple = Color(0xFF8B5CF6); // Medium purple
  // ignore: unused_field
  static const Color _deepPurple = Color(0xFF5B21B6); // Dark purple
  static const Color _lightPurple = Color(0xFFEDE9FE); // Very light purple
  static const Color _purpleGrey = Color(
    0xFFF3F4F6,
  ); // Light grey with purple tint

  // Additional colors
  static const Color _darkBackground = Color(0xFF0F0F23);
  static const Color _darkSurface = Color(0xFF1A1A2E);
  static const Color _darkCard = Color(0xFF16213E);

  // Light theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Color scheme
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryPurple,
        brightness: Brightness.light,
        primary: _primaryPurple,
        secondary: _secondaryPurple,
        tertiary: _accentPurple,
        surface: Colors.white,
        background: _purpleGrey,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.black87,
        onBackground: Colors.black87,
      ),

      // App bar theme
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),

      // Card theme
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.white,
        shadowColor: _primaryPurple.withValues(alpha: 0.1),
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryPurple,
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: _primaryPurple.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      // Outlined button theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _primaryPurple,
          side: BorderSide(color: _primaryPurple, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _primaryPurple,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      // Floating action button theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _primaryPurple,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _primaryPurple, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        contentPadding: const EdgeInsets.all(16),
        hintStyle: TextStyle(color: Colors.grey.shade500),
        labelStyle: const TextStyle(color: _primaryPurple),
      ),

      // Bottom navigation bar theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: _primaryPurple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
      ),

      // Switch theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.selected)) {
            return _primaryPurple;
          }
          return Colors.grey.shade400;
        }),
        trackColor: WidgetStateProperty.resolveWith<Color>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.selected)) {
            return _primaryPurple.withValues(alpha: 0.3);
          }
          return Colors.grey.shade300;
        }),
      ),

      // Slider theme
      sliderTheme: SliderThemeData(
        activeTrackColor: _primaryPurple,
        inactiveTrackColor: _primaryPurple.withValues(alpha: 0.3),
        thumbColor: _primaryPurple,
        overlayColor: _primaryPurple.withValues(alpha: 0.2),
      ),

      // Progress indicator theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: _primaryPurple,
        linearTrackColor: _lightPurple,
        circularTrackColor: _lightPurple,
      ),

      // Divider theme
      dividerTheme: DividerThemeData(
        color: Colors.grey.shade200,
        thickness: 1,
        space: 1,
      ),
    );
  }

  // Dark theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // Color scheme
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryPurple,
        brightness: Brightness.dark,
        primary: _secondaryPurple,
        secondary: _accentPurple,
        tertiary: _primaryPurple,
        surface: _darkSurface,
        // ignore: deprecated_member_use
        background: _darkBackground,
        onPrimary: Colors.black,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        // ignore: deprecated_member_use
        onBackground: Colors.white,
      ),

      // App bar theme
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),

      // Card theme
      cardTheme: CardThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: _darkCard,
        shadowColor: Colors.black.withValues(alpha: 0.3),
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _secondaryPurple,
          foregroundColor: Colors.white,
          elevation: 3,
          shadowColor: _secondaryPurple.withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      // Outlined button theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _secondaryPurple,
          side: BorderSide(color: _secondaryPurple, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _secondaryPurple,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      // Floating action button theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _secondaryPurple,
        foregroundColor: Colors.white,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _darkCard,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade600),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade600),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _secondaryPurple, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
        ),
        contentPadding: const EdgeInsets.all(16),
        hintStyle: TextStyle(color: Colors.grey.shade400),
        labelStyle: const TextStyle(color: _secondaryPurple),
      ),

      // Bottom navigation bar theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: _darkSurface,
        selectedItemColor: _secondaryPurple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
      ),

      // Switch theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.selected)) {
            return _secondaryPurple;
          }
          return Colors.grey.shade600;
        }),
        trackColor: WidgetStateProperty.resolveWith<Color>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.selected)) {
            return _secondaryPurple.withValues(alpha: 0.3);
          }
          return Colors.grey.shade700;
        }),
      ),

      // Slider theme
      sliderTheme: SliderThemeData(
        activeTrackColor: _secondaryPurple,
        inactiveTrackColor: _secondaryPurple.withValues(alpha: 0.3),
        thumbColor: _secondaryPurple,
        overlayColor: _secondaryPurple.withValues(alpha: 0.2),
      ),

      // Progress indicator theme
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: _secondaryPurple,
        linearTrackColor: Colors.grey.shade700,
        circularTrackColor: Colors.grey.shade700,
      ),

      // Divider theme
      dividerTheme: DividerThemeData(
        color: Colors.grey.shade700,
        thickness: 1,
        space: 1,
      ),
    );
  }
}

// Usage example in your main.dart:
/*
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Purple Theme App',
      theme: ModernPurpleTheme.lightTheme,
      darkTheme: ModernPurpleTheme.darkTheme,
      themeMode: ThemeMode.system, // Automatically switch based on system preference
      home: MyHomePage(),
    );
  }
}
*/
