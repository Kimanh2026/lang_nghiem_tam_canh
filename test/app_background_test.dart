import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lang_nghiem_tam_canh/widgets/app_background.dart';

class _RecordingBundle extends CachingAssetBundle {
  final requestedImage = Completer<String>();

  @override
  Future<ByteData> load(String key) async {
    if (key.endsWith('.png') && !requestedImage.isCompleted) {
      requestedImage.complete(key);
    }
    return rootBundle.load(key);
  }
}

void main() {
  Future<String> backgroundAssetForWidth(
    WidgetTester tester,
    double width,
  ) async {
    tester.view.physicalSize = Size(width, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final bundle = _RecordingBundle();
    await tester.pumpWidget(
      DefaultAssetBundle(
        bundle: bundle,
        child: const MaterialApp(home: AppBackground(child: SizedBox.expand())),
      ),
    );
    return (await tester.runAsync(() => bundle.requestedImage.future))!;
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
