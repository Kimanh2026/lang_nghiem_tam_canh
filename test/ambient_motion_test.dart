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
  });
}
