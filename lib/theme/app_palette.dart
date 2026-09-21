import 'package:flutter/material.dart';

class AppPalette {
  const AppPalette._();

  /// Shared, light glass surfaces that keep the sky visible while preserving
  /// enough contrast for white copy on every main screen.
  static const glassPanel = Color(0x821B2D38);
  static const glassPanelHighlight = Color(0x82465964);

  static const readableTextShadow = <Shadow>[
    Shadow(color: Color(0xB8000000), blurRadius: 5, offset: Offset(0, 1)),
  ];
}
