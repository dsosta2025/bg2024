import 'package:flutter/material.dart';

class AppColors {
  // Solid Colors
  static const Color dark = Color(0xFF231A18);
  static const Color orange = Color(0xFFF05D31);
  static const Color orange2 = Color(0xFFFC8D2C);
  static const Color white = Color(0xFFFAFAFA);
  static const Color lightPeach = Color(0xFFFFE7E0);
  static const Color mediumGray = Color(0x26B2B2B2);

  static LinearGradient getOrangeGradient() {
    return LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.centerRight,
      colors: [
        AppColors.orange,
        AppColors.orange2,
        AppColors.orange2.withOpacity(0.8),
      ],
    );
  }
  // Gradients
  static const List<Color> orangeGradient = [
    Color(0xFFF05D31),
    Color(0xFFFC8D2C),
  ];

  static const List<Color> blueGradient = [
    Color(0xFF1B6FB5),
    Color(0xFF4AAAFA),
  ];
}
