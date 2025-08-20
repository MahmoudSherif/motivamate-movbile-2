import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Space theme colors
  static const Color primaryTeal = Color(0xFF1A6B6B);
  static const Color warmOrange = Color(0xFFE67E22);
  static const Color spaceBlue = Color(0xFF0F172A);
  static const Color starWhite = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0x33000000);
  static const Color glassBorder = Color(0x1AFFFFFF);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: MaterialColor(
        primaryTeal.value,
        <int, Color>{
          50: primaryTeal.withOpacity(0.1),
          100: primaryTeal.withOpacity(0.2),
          200: primaryTeal.withOpacity(0.3),
          300: primaryTeal.withOpacity(0.4),
          400: primaryTeal.withOpacity(0.5),
          500: primaryTeal,
          600: primaryTeal.withOpacity(0.7),
          700: primaryTeal.withOpacity(0.8),
          800: primaryTeal.withOpacity(0.9),
          900: primaryTeal.withOpacity(1.0),
        },
      ),
      primaryColor: primaryTeal,
      scaffoldBackgroundColor: spaceBlue,
      cardColor: cardBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: starWhite,
        ),
        iconTheme: const IconThemeData(color: starWhite),
      ),
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.inter(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: starWhite,
        ),
        headlineMedium: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: starWhite,
        ),
        headlineSmall: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: starWhite,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: starWhite,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: starWhite.withOpacity(0.8),
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: starWhite.withOpacity(0.6),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryTeal,
          foregroundColor: starWhite,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: glassBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: glassBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryTeal, width: 2),
        ),
        hintStyle: TextStyle(color: starWhite.withOpacity(0.5)),
        labelStyle: const TextStyle(color: starWhite),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarTheme(
        backgroundColor: cardBackground,
        selectedItemColor: primaryTeal,
        unselectedItemColor: starWhite,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        color: cardBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: glassBorder, width: 1),
        ),
      ),
    );
  }

  // Custom gradient for space background
  static const LinearGradient spaceGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF0F172A),
      Color(0xFF1E293B),
      Color(0xFF334155),
    ],
  );
}