import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lang_nghiem_tam_canh/release_notes.dart';

void main() {
  test('release announcement is shown once per version', () {
    expect(AppReleaseNotes.shouldAnnounce(null), isTrue);
    expect(AppReleaseNotes.shouldAnnounce('1.4.3+16'), isTrue);
    expect(AppReleaseNotes.shouldAnnounce(AppReleaseNotes.version), isFalse);
  });

  testWidgets('release notes dialog shows version and changes', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () => showCurrentReleaseNotes(context),
              child: const Text('Mở cập nhật'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Mở cập nhật'));
    await tester.pumpAndSettle();

    expect(find.text('ỨNG DỤNG ĐÃ ĐƯỢC CẬP NHẬT'), findsOneWidget);
    expect(find.text('Phiên bản 1.5.15'), findsOneWidget);
    for (final change in AppReleaseNotes.changes) {
      expect(find.text(change), findsOneWidget);
    }
    expect(find.text('Đã hiểu'), findsOneWidget);
  });
}
