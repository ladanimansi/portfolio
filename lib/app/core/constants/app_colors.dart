import 'package:flutter/material.dart';

class AppColors {
  // Primary brand colors
  static const Color primary = Color(0xFF00B4D8); // Vibrant Cyan
  static const Color primaryDark = Color(0xFF0077B6);
  static const Color accent = Color(0xFF7209B7); // Vibrant Violet / Purple
  static const Color secondary = Color(0xFF48CAE4);
  
  // Dark Theme Palette
  static const Color darkBackground = Color(0xFF0B0F19); // Rich Obsidian
  static const Color darkSurface = Color(0xFF131B2E);
  static const Color darkCard = Color(0xFF1B243B);
  static const Color darkTextPrimary = Color(0xFFF1F5F9);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkBorder = Color(0xFF263353);

  // Light Theme Palette
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFF1F5F9);
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF64748B);
  static const Color lightBorder = Color(0xFFE2E8F0);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF00B4D8), Color(0xFF7209B7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF1B243B), Color(0xFF131B2E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient neonGlowGradient = LinearGradient(
    colors: [Color(0x3300B4D8), Color(0x1A7209B7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

