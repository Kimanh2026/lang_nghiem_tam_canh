import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lang_nghiem_tam_canh/screens/home_screen.dart';

void main() {
  test('home schedule section exposes the global app background', () {
    final source = File('lib/screens/home_screen.dart').readAsStringSync();

    expect(source, isNot(contains('assets/images/lotus-dawn.png')));
  });

  testWidgets('schedule invitation has no colored panel background', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: HomeScreen(recitationCount: ValueNotifier<int>(0))),
    );

    final containers = tester.widgetList<Container>(
      find.ancestor(
        of: find.text('Trở về\nvới tâm an'),
        matching: find.byType(Container),
      ),
    );
    final coloredContainers = containers.where((container) {
      final decoration = container.decoration;
      return decoration is BoxDecoration && decoration.color != null;
    });

    expect(coloredContainers, isEmpty);
  });
}
