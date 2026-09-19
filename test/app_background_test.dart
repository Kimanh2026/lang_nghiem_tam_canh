import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lang_nghiem_tam_canh/widgets/app_background.dart';

void main() {
  Future<String> backgroundAssetForWidth(
    WidgetTester tester,
    double width,
  ) async {
    tester.view.physicalSize = Size(width, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(home: AppBackground(child: SizedBox.expand())),
    );

    final image = tester.widget<Image>(find.byType(Image));
    return (image.image as AssetImage).assetName;
  }

  testWidgets('uses portrait artwork on mobile', (tester) async {
    expect(
      await backgroundAssetForWidth(tester, 390),
      'assets/images/app-background-mobile-v1.png',
    );
  });

  testWidgets('uses landscape artwork on desktop', (tester) async {
    expect(
      await backgroundAssetForWidth(tester, 1024),
      'assets/images/app-background-desktop-v1.png',
    );
  });
}
