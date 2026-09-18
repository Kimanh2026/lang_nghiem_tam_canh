import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lang_nghiem_tam_canh/screens/teachings_screen.dart';

void main() {
  Future<void> pumpTeachings(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1024, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.dark(useMaterial3: true),
        home: const TeachingsScreen(),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('Teachings use one continuous reading scroll', (tester) async {
    await pumpTeachings(tester);

    expect(find.byType(AppBar), findsNothing);
    expect(find.byType(TextField), findsNothing);
    expect(find.text('Khai Thị & Tín Tâm'), findsNothing);
    expect(find.text('Tìm kiếm lời khai thị...'), findsNothing);
    expect(find.text('Thời Đại “Vô Cùng Nguy Ngập”'), findsOneWidget);
    expect(find.text('Hòa Thượng Tuyên Hóa'), findsOneWidget);

    await tester.drag(
      find.byKey(const Key('teachings-scroll')),
      const Offset(0, -500),
    );
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('teacher-hero')).hitTestable(), findsNothing);
    expect(find.text('Thời Đại “Vô Cùng Nguy Ngập”'), findsWidgets);
  });

  testWidgets('Teacher filter changes content without duplicate attribution', (
    tester,
  ) async {
    await pumpTeachings(tester);
    await tester.tap(find.text('Hòa Thượng Phổ Quang'));
    await tester.pumpAndSettle();

    expect(find.text('Hòa Thượng Phổ Quang'), findsOneWidget);
    expect(find.text('Cột Mốc 36.000 Biến & Đài Sen Nâng Đỡ'), findsOneWidget);
    expect(find.text('Thời Đại “Vô Cùng Nguy Ngập”'), findsNothing);

    final target = find.text('Trì Chú Cần Chí Thành Chuyên Nhất');
    await tester.scrollUntilVisible(
      target,
      600,
      scrollable: find
          .descendant(
            of: find.byKey(const Key('teachings-scroll')),
            matching: find.byType(Scrollable),
          )
          .first,
    );
    expect(target, findsOneWidget);
  });
}
