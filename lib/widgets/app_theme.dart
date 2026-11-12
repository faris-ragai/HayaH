import 'package:flutter/material.dart';

class AppColors {
  static const green = Color(0xFF2F7D4B);
  static const greenDark = Color(0xFF25693F);
  static const tint = Color(0xFFDBEFD9);
  static const tintBorder = Color(0xFFC3E0C0);
  static const bg = Color(0xFFF7F8F3);
  static const outline = Color(0xFFDFE6DA);
  static const fieldBorder = Color(0xFFCFE3CB);
  static const ink = Color(0xFF1B2B1F);
  static const muted = Color(0xFF5B655C);
}

class AppText {
  static const title =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.ink);
  static const sub = TextStyle(fontSize: 12, color: AppColors.muted);
  static const value = TextStyle(fontSize: 13.5, color: AppColors.ink);
  static const label = TextStyle(fontSize: 11.5, color: AppColors.muted);
  static const note = TextStyle(fontSize: 11.5, color: AppColors.muted, height: 1.45);
}

/// Rounded border used by every text field and dropdown.
OutlineInputBorder appFieldBorder([Color color = AppColors.fieldBorder, double width = 1]) =>
    OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color, width: width),
    );

/// Vertical gap used between cards and fields.
const kGap = SizedBox(height: 11);

class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.green,
          primary: AppColors.green,
        ),
        scaffoldBackgroundColor: AppColors.bg,
      );
}
