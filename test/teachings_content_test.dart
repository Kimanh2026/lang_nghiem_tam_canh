import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lang_nghiem_tam_canh/screens/teachings_screen.dart';

void main() {
  testWidgets('New teachings appear under the correct teacher filters', (
    tester,
  ) async {
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

    const tuyenHoaTitles = [
      'THẦN CHÚ KHAI MỞ TRÍ TUỆ',
      'THẬT SỰ CÓ THỂ TRÌ CHÚ LĂNG NGHIÊM, TRONG HƯ KHÔNG LIỀN CÓ MỘT ĐẠI BẠCH TÁN CÁI, CÓ OAI THẦN LỰC “PHỔ ẤM MUÔN PHƯƠNG”!',
      'NIỆM CHÚ LĂNG NGHIÊM BẢY NGÀY, CĂN BỆNH LẠ BỖNG NHIÊN KHỎI HẲN',
    ];
    const phoQuangTitles = [
      'BUÔNG VÕ CÔNG, VÀO CHUNG NAM SƠN ĂN LÁ CÂY 72 NĂM',
      'Trì Chú Cần Chí Thành Chuyên Nhất',
      'MUỐN NHANH CHÓNG THÀNH TỰU, HÃY TỤNG THUỘC CHÚ LĂNG NGHIÊM',
    ];

    for (final title in tuyenHoaTitles) {
      await tester.enterText(find.byType(TextField), title);
      await tester.pumpAndSettle();
      expect(
        find.descendant(of: find.byType(ListView), matching: find.text(title)),
        findsOneWidget,
      );
      expect(
        find.text('Hòa Thượng Tuyên Hóa'),
        findsOneWidget,
        reason: 'Tên tác giả chỉ nên xuất hiện trên ô lọc',
      );
    }

    await tester.enterText(find.byType(TextField), phoQuangTitles.first);
    await tester.pumpAndSettle();
    expect(find.text('Không tìm thấy lời khai thị nào.'), findsOneWidget);

    await tester.tap(find.text('Hòa Thượng Phổ Quang'));
    await tester.pumpAndSettle();

    for (final title in phoQuangTitles) {
      await tester.enterText(find.byType(TextField), title);
      await tester.pumpAndSettle();
      expect(
        find.descendant(of: find.byType(ListView), matching: find.text(title)),
        findsOneWidget,
      );
      expect(
        find.text('Hòa Thượng Phổ Quang'),
        findsOneWidget,
        reason: 'Tên tác giả chỉ nên xuất hiện trên ô lọc',
      );
    }

    await tester.enterText(find.byType(TextField), tuyenHoaTitles.first);
    await tester.pumpAndSettle();
    expect(find.text('Không tìm thấy lời khai thị nào.'), findsOneWidget);
  });
}
