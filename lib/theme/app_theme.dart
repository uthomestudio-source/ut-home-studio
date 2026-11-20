import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color obsidianBlack = Color(0xFF0A0A0B);
  static const Color charcoalCard = Color(0xFF141417);
  static const Color darkSurface = Color(0xFF1E1E24);
  static const Color pureWhite = Color(0xFFFFFFFF);
  static const Color softIvory = Color(0xFFF5F3EF);
  static const Color mutedSilver = Color(0xFFA0A0AB);
  static const Color champagneGold = Color(0xFFD4AF37);
  static const Color warmGoldLight = Color(0xFFF3E5AB);
  static const Color goldBorder = Color(0x4DD4AF37);

  static ThemeData get darkLuxuryTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: obsidianBlack,
      primaryColor: champagneGold,
      colorScheme: const ColorScheme.dark(
        primary: champagneGold,
        secondary: warmGoldLight,
        surface: charcoalCard,
        onPrimary: obsidianBlack,
        onSurface: pureWhite,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.cormorantGaramond(fontSize: 32, fontWeight: FontWeight.w700, color: pureWhite, letterSpacing: 1.1),
        headlineMedium: GoogleFonts.cormorantGaramond(fontSize: 24, fontWeight: FontWeight.w600, color: pureWhite),
        titleMedium: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w600, color: pureWhite),
        bodyMedium: GoogleFonts.plusJakartaSans(fontSize: 14, color: mutedSilver, height: 1.5),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: obsidianBlack,
        elevation: 0,
        titleTextStyle: GoogleFonts.cormorantGaramond(fontSize: 20, fontWeight: FontWeight.w700, color: champagneGold, letterSpacing: 1.5),
        iconTheme: const IconThemeData(color: champagneGold),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: champagneGold,
          foregroundColor: obsidianBlack,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, fontSize: 14, letterSpacing: 0.5),
        ),
      ),
    );
  }
}
