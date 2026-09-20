import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('GitHub Pages deploys the committed Flutter web build at repo path', () {
    final workflow = File(
      '.github/workflows/deploy-pages.yml',
    ).readAsStringSync();

    expect(workflow, contains('branches:\n      - main'));
    expect(workflow, contains('pages: write'));
    expect(workflow, contains('id-token: write'));
    expect(workflow, contains('path: _site'));
    expect(workflow, contains('<base href="/lang_nghiem_tam_canh/">'));
    expect(workflow, contains('actions/deploy-pages@v4'));
  });
}
