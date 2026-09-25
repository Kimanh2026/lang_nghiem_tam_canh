import 'package:flutter/material.dart';

class AppPalette {
  const AppPalette._();

  /// Shared, light glass surfaces that keep the sky visible while preserving
  /// enough contrast for white copy on every main screen.
  static const glassPanel = Color(0x821B2D38);
  static const glassPanelHighlight = Color(0x82465964);

  static const primaryText = Color(0xFFFFFFFF);
  static const secondaryText = Color(0xFFFDF7EF);
  static const mutedText = Color(0xFFE8E0D7);

  static const readableTextShadow = <Shadow>[
    Shadow(color: Color(0xE6000000), blurRadius: 6, offset: Offset(0, 1)),
    Shadow(color: Color(0x80000000), blurRadius: 1, offset: Offset(0, 1)),
  ];

  /// Crisp navigation and section-heading colors for the brightest areas of
  /// the sky artwork. These intentionally use dark ink instead of white.
  static const menuText = Color(0xFF243D49);
  static const menuSelectedText = Color(0xFF8A5A00);
  static const sectionHeadingText = Color(0xFF875900);
  static const crispTextShadow = <Shadow>[
    Shadow(color: Color(0xF2FFFFFF), blurRadius: 2),
    Shadow(color: Color(0x33000000), blurRadius: 1, offset: Offset(0, 1)),
  ];
}
