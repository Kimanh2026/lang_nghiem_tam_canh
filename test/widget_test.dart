import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lang_nghiem_tam_canh/main.dart';

void main() {
  testWidgets('Main navigation has five screens and no author section', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1024, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.dark(useMaterial3: true),
        home: MainScaffold(
          recitationCount: ValueNotifier<int>(0),
          userName: ValueNotifier<String>(''),
          clearChatTrigger: ValueNotifier<int>(0),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('desktop-navigation')), findsOneWidget);
    for (var index = 0; index < 5; index++) {
      expect(find.byKey(ValueKey('desktop-nav-item-$index')), findsOneWidget);
      expect(
        tester
            .getTopLeft(find.byKey(ValueKey('desktop-nav-icon-slot-$index')))
            .dx,
        tester
            .getTopLeft(find.byKey(const ValueKey('desktop-nav-icon-slot-0')))
            .dx,
      );
    }
    expect(find.byKey(const Key('nav-home-selected')), findsOneWidget);
    expect(find.byKey(const Key('nav-teachings-idle')), findsOneWidget);
    expect(find.byKey(const Key('nav-mantra-idle')), findsOneWidget);
    expect(find.byKey(const Key('nav-chat-idle')), findsOneWidget);
    expect(find.byKey(const Key('nav-settings-idle')), findsOneWidget);
    expect(
      tester.getSize(find.byKey(const Key('nav-home-selected'))),
      const Size(48, 42),
    );
    expect(
      tester.widget(find.byKey(const Key('nav-home-selected'))),
      isA<SizedBox>(),
    );
    final iconRight = tester
        .getTopRight(find.byKey(const ValueKey('desktop-nav-icon-slot-0')))
        .dx;
    final labelLeft = tester.getTopLeft(find.text('Trang chủ')).dx;
    expect(labelLeft - iconRight, lessThanOrEqualTo(10));
    expect(find.text('Tác Giả'), findsNothing);
    expect(find.text('Cài đặt'), findsOneWidget);
  });
}
