import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('home schedule section exposes the global app background', () {
    final source = File('lib/screens/home_screen.dart').readAsStringSync();

    expect(source, isNot(contains('assets/images/lotus-dawn.png')));
    expect(source, contains('AppPalette.glassPanel'));
  });
}
