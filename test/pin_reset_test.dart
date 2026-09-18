import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lang_nghiem_tam_canh/screens/pin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('Resetting PIN keeps recitation progress and other data', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({
      'app_pin': '9876',
      'recitationCount': 108,
      'user_name': 'Liên Hoa',
    });

    await tester.pumpWidget(
      MaterialApp(
        home: PinScreen(
          savedPin: '9876',
          recitationCount: ValueNotifier<int>(108),
        ),
      ),
    );

    expect(find.text('Nhập mã PIN để mở app'), findsOneWidget);
    await tester.tap(find.text('Quên mã PIN?'));
    await tester.pumpAndSettle();

    expect(find.text('Đặt lại mã PIN?'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Đặt lại'));
    await tester.pumpAndSettle();

    expect(find.text('Tạo mã PIN mới'), findsOneWidget);

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('app_pin'), isNull);
    expect(prefs.getInt('recitationCount'), 108);
    expect(prefs.getString('user_name'), 'Liên Hoa');
  });
}
