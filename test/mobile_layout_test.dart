import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lang_nghiem_tam_canh/main.dart';

void main() {
  for (final width in [320.0, 390.0, 430.0, 1024.0]) {
    testWidgets('All six screens fit width $width', (tester) async {
      final errorHandler = FlutterError.onError;
      FlutterError.onError = (details) {
        debugPrint(details.toString());
        errorHandler?.call(details);
      };
      addTearDown(() => FlutterError.onError = errorHandler);
      tester.view.physicalSize = Size(width, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      SharedPreferences.setMockInitialValues({});
      await tester.pumpWidget(MaterialApp(
        theme: ThemeData.dark(useMaterial3: true),
        home: MainScaffold(
          recitationCount: ValueNotifier(0),
          userName: ValueNotifier('Đạo hữu'),
          clearChatTrigger: ValueNotifier(0),
        ),
      ));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(find.byType(NavigationRail), width < 600 ? findsNothing : findsOneWidget);
      for (final label in ['Khai thị', 'Trì chú', 'Tiểu Tịnh', 'Tác Giả', 'Cài đặt', 'Trang chủ']) {
        await tester.tap(find.text(label).last);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull, reason: '$label at $width');
      }
    });
  }
}
