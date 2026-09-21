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
    expect(find.byKey(const Key('teacher-hero-images')), findsOneWidget);
    expect(find.byKey(const ValueKey('teacher-hero-image-4')), findsOneWidget);
    expect(find.text('25 bài'), findsOneWidget);

    await tester.drag(
      find.byKey(const Key('teachings-scroll')),
      const Offset(0, -500),
    );
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('teacher-hero')).hitTestable(), findsNothing);
    expect(find.text('CUỘC ĐỜI HÒA THƯỢNG TUYÊN HÓA'), findsWidgets);
  });

  testWidgets('Tuyên Hóa hero presents five equal portraits in one row', (
    tester,
  ) async {
    await pumpTeachings(tester);

    final firstSize = tester.getSize(
      find.byKey(const ValueKey('teacher-hero-image-0')),
    );
    for (var index = 1; index < 5; index++) {
      expect(
        tester.getSize(find.byKey(ValueKey('teacher-hero-image-$index'))),
        firstSize,
      );
    }
    final firstTop = tester.getTopLeft(
      find.byKey(const ValueKey('teacher-hero-image-0')),
    );
    final lastTop = tester.getTopLeft(
      find.byKey(const ValueKey('teacher-hero-image-4')),
    );
    expect((firstTop.dy - lastTop.dy).abs(), lessThan(1));
    expect(find.textContaining('Vuốt ngang để xem'), findsNothing);
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

  test('Tuyên Hóa content and selected hero portraits are retained', () {
    final source = File('lib/screens/teachings_screen.dart').readAsStringSync();
    final addedTeaching = File(
      'lib/content/tuyen_hoa_phap_than.dart',
    ).readAsStringSync();

    expect(source, contains('Hòa thượng Tuyên Hóa đản sanh vào giờ Tý'));
    expect(source, contains('Mỗi ngày Ngài lạy 837 lạy'));
    expect(source, contains('PHẦN II: NHỮNG LẦN ĐỘ SANH KỲ BÍ'));
    expect(source, contains('Lăng Nghiêm hưng thì Phật pháp hưng'));
    expect(source, contains('Không chấp tướng thời gian'));
    for (final image in [
      '01.webp',
      '02.webp',
      '03.webp',
      '05.webp',
      '08.jpg',
    ]) {
      expect(source, contains('assets/images/tuyen-hoa-$image'));
    }
    expect(
      addedTeaching,
      contains('Thành tâm tụng Chú Lăng Nghiêm, thì không cần trải qua'),
    );
    for (final article in {
      'HAI MƯƠI BỐN ÍCH LỢI CỦA SỰ PHIÊN DỊCH':
          'tuyenHoaHaiMuoiBonIchLoi',
      'TIÊU TAI, NHIẾP TRIỆU VÀ HÀNG PHỤC':
          'tuyenHoaTieuTaiNhiepTrieu',
      'VÌ SAO TỤNG TRÌ KINH CHÚ KHÔNG CÔNG HIỆU?':
          'tuyenHoaViSaoKhongCongHieu',
      'NHỮNG CẢNH GIỚI KHI DỤNG CÔNG TRÌ CHÚ':
          'tuyenHoaNhungCanhGioi',
      'HỮU HỌC VÀ VÔ HỌC': 'tuyenHoaHuuHocVaVoHoc',
      'CHÚ LĂNG NGHIÊM LÀ “LINH VĂN”': 'tuyenHoaLinhVan',
      'HAI MƯƠI CHÍN CÂU ĐẦU CỦA CHÚ LĂNG NGHIÊM':
          'tuyenHoaHaiMuoiChinCau',
      'NĂM ĐẠI TÂM CHÚ': 'tuyenHoaNamDaiTamChu',
      'MUỐN CẦU PHƯỚC BÁU THẾ GIAN HAY QUẢ BÁU THÁNH HIỀN ĐỀU NÊN TỤNG CHÚ LĂNG NGHIÊM':
          'tuyenHoaCauPhuocBao',
    }.entries) {
      expect(source, contains(article.key));
      expect(source, contains("'preview': ${article.value}"));
    }
    expect(
      source,
      isNot(contains('Bằng nguyện lực "địa ngục chưa trống thề không thành Phật')),
    );
    expect(source, isNot(contains('BUÔNG VÕ CÔNG, VÀO CHUNG NAM SƠN')));
  });
}
