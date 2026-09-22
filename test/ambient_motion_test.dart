import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lang_nghiem_tam_canh/widgets/app_background.dart';

void main() {
  testWidgets('ambient background moves slowly and paints light particles', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: AppBackground(child: SizedBox.expand())),
    );

    List<double> transformValues() => List<double>.from(
      tester
          .widget<Transform>(
            find.byKey(const Key('ambient-background-transform')),
          )
          .transform
          .storage,
    );

    final before = transformValues();
    await tester.pump(const Duration(seconds: 3));
    final after = transformValues();

    expect(after, isNot(equals(before)));
    expect(find.byKey(const Key('ambient-light-particles')), findsOneWidget);
    expect(
      find.ancestor(
        of: find.byKey(const Key('ambient-light-particles')),
        matching: find.byKey(const Key('ambient-background-transform')),
      ),
      findsOneWidget,
    );
  });

  test(
    'animated flame remains attached to the moving background transform',
    () {
      final source = File('lib/widgets/app_background.dart').readAsStringSync();

      expect(source, contains('const Offset(473, 1188)'));
      expect(source, contains('math.sin(phase * 4) * 3.0'));
      expect(source, contains('math.sin(phase * 7) * 0.85'));
      expect(source, contains('producing a seamless loop'));
      expect(source, contains('Duration(seconds: 20)'));
    },
  );
}
