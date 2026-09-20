import 'dart:io';

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
    expect(find.text('CUỘC ĐỜI HÒA THƯỢNG TUYÊN HÓA'), findsOneWidget);
    expect(find.text('Hòa Thượng Tuyên Hóa'), findsOneWidget);
    expect(find.byKey(const Key('tuyen-hoa-gallery')), findsOneWidget);

    await tester.drag(
      find.byKey(const Key('teachings-scroll')),
      const Offset(0, -500),
    );
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('teacher-hero')).hitTestable(), findsNothing);
    expect(find.text('CUỘC ĐỜI HÒA THƯỢNG TUYÊN HÓA'), findsWidgets);
  });

  testWidgets('Tuyên Hóa biography includes a horizontally scrollable gallery', (
    tester,
  ) async {
    await pumpTeachings(tester);

    expect(
      find.text('8 ảnh về Hòa Thượng • Vuốt ngang để xem'),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('tuyen-hoa-gallery-image-0')),
      findsOneWidget,
    );

    await tester.drag(
      find.byKey(const Key('tuyen-hoa-gallery')),
      const Offset(-1900, 0),
    );
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('tuyen-hoa-gallery-image-7')),
      findsOneWidget,
    );
  });

  testWidgets('Teacher filter changes content without duplicate attribution', (
    tester,
  ) async {
    await pumpTeachings(tester);
    await tester.tap(find.text('Hòa Thượng Phổ Quang'));
    await tester.pumpAndSettle();

    expect(find.text('Hòa Thượng Phổ Quang'), findsOneWidget);
    expect(
      find.text('Cuộc Đời Và Đạo Nghiệp Của Hòa Thượng Phổ Quang'),
      findsOneWidget,
    );
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

  test('Phổ Quang biography keeps the supplied key passages verbatim', () {
    final source = File('lib/screens/teachings_screen.dart').readAsStringSync();

    expect(source, contains('Ngài sinh vào ngày 8 tháng 4 năm 1901'));
    expect(source, contains('Học kinh bằng "3 câu đổi 1 miếng cơm"'));
    expect(source, contains('Đục 5.000 bậc thang đá'));
    expect(source, contains('Kỷ lục 5,6 triệu biến Lăng Nghiêm'));
    expect(source, contains('Ngài vừa đi vừa trì tụng 108 biến Lăng Nghiêm'));
  });

  test('Tuyên Hóa biography keeps the supplied sections and all eight images', () {
    final source = File('lib/screens/teachings_screen.dart').readAsStringSync();

    expect(source, contains('Hòa thượng Tuyên Hóa đản sanh vào giờ Tý'));
    expect(source, contains('Mỗi ngày Ngài lạy 837 lạy'));
    expect(source, contains('PHẦN II: NHỮNG LẦN ĐỘ SANH KỲ BÍ'));
    expect(source, contains('Lăng Nghiêm hưng thì Phật pháp hưng'));
    expect(source, contains('Không chấp tướng thời gian'));
    for (var index = 1; index <= 8; index++) {
      final extension = index <= 6 ? 'webp' : 'jpg';
      expect(
        source,
        contains(
          'assets/images/tuyen-hoa-${index.toString().padLeft(2, '0')}.$extension',
        ),
      );
    }
  });
}
