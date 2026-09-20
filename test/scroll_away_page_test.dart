import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lang_nghiem_tam_canh/widgets/scroll_away_page.dart';

void main() {
  testWidgets('page header collapses while reading and returns at the top', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ScrollAwayPage(
          title: 'Tiêu đề',
          body: ListView.builder(
            itemCount: 40,
            itemBuilder: (_, index) =>
                SizedBox(height: 60, child: Text('Dòng $index')),
          ),
        ),
      ),
    );

    double headerHeight() =>
        tester.getSize(find.byKey(const Key('scroll-away-header'))).height;

    expect(headerHeight(), 57);
    await tester.drag(find.byType(ListView), const Offset(0, -180));
    await tester.pumpAndSettle();
    expect(headerHeight(), 0);

    await tester.drag(find.byType(ListView), const Offset(0, 500));
    await tester.pumpAndSettle();
    expect(headerHeight(), 57);
  });
}
