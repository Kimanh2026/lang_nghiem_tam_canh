import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lang_nghiem_tam_canh/theme/app_palette.dart';

void main() {
  test('glass surfaces share one readable opacity', () {
    expect(AppPalette.glassPanel.a, closeTo(0x82 / 255, 0.001));
    expect(AppPalette.glassPanelHighlight.a, closeTo(0x82 / 255, 0.001));
    expect(AppPalette.readableTextShadow, isNotEmpty);
  });

  test('navigation and settings headings stay readable on a bright sky', () {
    double contrast(Color foreground, Color background) {
      final lighter =
          foreground.computeLuminance() > background.computeLuminance()
          ? foreground.computeLuminance()
          : background.computeLuminance();
      final darker =
          foreground.computeLuminance() > background.computeLuminance()
          ? background.computeLuminance()
          : foreground.computeLuminance();
      return (lighter + 0.05) / (darker + 0.05);
    }

    expect(contrast(AppPalette.menuText, Colors.white), greaterThan(4.5));
    expect(
      contrast(AppPalette.menuSelectedText, Colors.white),
      greaterThan(4.5),
    );
    expect(
      contrast(AppPalette.sectionHeadingText, Colors.white),
      greaterThan(4.5),
    );
    expect(AppPalette.crispTextShadow, isNotEmpty);
  });

  test('old mismatched panel opacities are no longer used', () {
    const oldPanelColors = <String>[
      '0xE6253944',
      '0xE61B2D38',
      '0xF2253944',
      '0xC91B2D38',
    ];
    final dartFiles = Directory('lib')
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('.dart'));

    for (final file in dartFiles) {
      final source = file.readAsStringSync();
      for (final oldColor in oldPanelColors) {
        expect(source, isNot(contains(oldColor)), reason: file.path);
      }
    }
  });
}
