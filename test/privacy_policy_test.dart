import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lang_nghiem_tam_canh/screens/privacy_policy_screen.dart';

void main() {
  testWidgets(
    'privacy policy uses a readable panel and current contact email',
    (tester) async {
      await tester.pumpWidget(const MaterialApp(home: PrivacyPolicyScreen()));

      expect(find.textContaining('xavia.nguyen97@gmail.com'), findsOneWidget);
      expect(find.textContaining('nkimanh932@gmail.com'), findsNothing);

      final panel = tester.widget<Container>(
        find.byKey(const Key('privacy-readable-panel')),
      );
      final decoration = panel.decoration! as BoxDecoration;
      expect(decoration.color, const Color(0xD91B2D38));
    },
  );
}
