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

    final rail = tester.widget<NavigationRail>(find.byType(NavigationRail));
    expect(rail.destinations, hasLength(5));
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
    expect(find.text('Tác Giả'), findsNothing);
    expect(find.text('Cài đặt'), findsOneWidget);
  });
}
