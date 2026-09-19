import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lang_nghiem_tam_canh/main.dart';

void main() {
  for (final width in [320.0, 390.0, 430.0, 1024.0]) {
    testWidgets('All five screens fit width $width', (tester) async {
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
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(useMaterial3: true),
          home: MainScaffold(
            recitationCount: ValueNotifier(0),
            userName: ValueNotifier('Đạo hữu'),
            clearChatTrigger: ValueNotifier(0),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(find.text('Liên Hoa Hóa Sanh'), findsNothing);
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is CircleAvatar &&
              widget.backgroundImage ==
                  const AssetImage('assets/images/avatar.jpg'),
        ),
        findsNothing,
      );
      expect(
        find.byType(NavigationRail),
        width < 600 ? findsNothing : findsOneWidget,
      );
      expect(find.text('Tác Giả'), findsNothing);
      for (final label in [
        'Khai thị',
        'Trì chú',
        'Tiểu Tịnh',
        'Cài đặt',
        'Trang chủ',
      ]) {
        await tester.tap(find.text(label).last);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull, reason: '$label at $width');
        if (label == 'Cài đặt') {
          expect(find.text('NHẮC THỜI KHÓA'), findsNothing);
          expect(find.text('Nhắc trì chú mỗi ngày'), findsNothing);
          expect(find.text('Nhắc ngày Phật giáo'), findsNothing);
          expect(find.text('Các ngày sắp tới'), findsOneWidget);
        }
      }
    });
  }

  testWidgets('Mobile prioritizes reading space over decorative images', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.dark(useMaterial3: true),
        home: MainScaffold(
          recitationCount: ValueNotifier(0),
          userName: ValueNotifier('Đạo hữu'),
          clearChatTrigger: ValueNotifier(0),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Khai thị').last);
    await tester.pumpAndSettle();
    expect(tester.getSize(find.byKey(const Key('teacher-hero'))).height, 84);
    await tester.drag(
      find.byKey(const Key('teachings-scroll')),
      const Offset(0, -300),
    );
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('teacher-hero')).hitTestable(), findsNothing);

    await tester.tap(find.text('Trì chú').last);
    await tester.pumpAndSettle();
    final readingViewport = find.byKey(const Key('mantra-reading-viewport'));
    expect(tester.getSize(readingViewport).height, greaterThanOrEqualTo(360));
    expect(tester.getSize(readingViewport).width, greaterThanOrEqualTo(360));
    expect(tester.getTopLeft(readingViewport).dy, lessThan(170));
    expect(find.byKey(const Key('practice-gallery')), findsNothing);
    expect(find.byKey(const Key('practice-gallery-desktop')), findsNothing);
  });

  testWidgets('Teacher portrait is centered and teacher tabs are prominent', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1024, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.dark(useMaterial3: true),
        home: MainScaffold(
          recitationCount: ValueNotifier(0),
          userName: ValueNotifier('Đạo hữu'),
          clearChatTrigger: ValueNotifier(0),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Khai thị').last);
    await tester.pumpAndSettle();

    final heroCenter = tester.getCenter(find.byKey(const Key('teacher-hero')));
    final imageCenter = tester.getCenter(
      find.byKey(const Key('selected-teacher-image')),
    );
    expect((heroCenter.dx - imageCenter.dx).abs(), lessThan(1));
    expect(
      tester.getSize(find.byKey(const Key('selected-teacher-image'))).height,
      157,
    );
    final selectedTab = tester.widget<ChoiceChip>(
      find.byKey(const ValueKey('teacher-tab-0')),
    );
    expect(selectedTab.selectedColor, const Color(0xFFD4AF37));
    expect(selectedTab.showCheckmark, isFalse);
  });

  testWidgets('Practice imagery is removed from the chanting screen', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1024, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.dark(useMaterial3: true),
        home: MainScaffold(
          recitationCount: ValueNotifier(0),
          userName: ValueNotifier('Đạo hữu'),
          clearChatTrigger: ValueNotifier(0),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Trì chú').last);
    await tester.pumpAndSettle();

    expect(find.text('Liên Hoa Hóa Sanh'), findsNothing);
    expect(find.byKey(const Key('practice-gallery')), findsNothing);
    expect(find.byKey(const Key('practice-gallery-desktop')), findsNothing);
    expect(
      find.byKey(const Key('mantra-reading-viewport')).hitTestable(),
      findsOneWidget,
    );

    await tester.tap(find.text('Tiểu Tịnh').last);
    await tester.pumpAndSettle();
    expect(find.text('Liên Hoa Hóa Sanh'), findsNothing);
  });
}
