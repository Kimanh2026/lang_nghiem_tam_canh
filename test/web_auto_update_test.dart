import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('mobile web app checks for and activates new deployments', () {
    final index = File('web/index.html').readAsStringSync();
    final bootstrap = File('web/flutter_bootstrap.js').readAsStringSync();
    final headers = File('web/_headers').readAsStringSync();
    final pubspec = File('pubspec.yaml').readAsStringSync();

    expect(pubspec, contains('version: 1.5.15+32'));
    expect(index, contains("const currentAppBuild = '1.5.15+32'"));
    expect(index, contains('version.json?check=\${Date.now()}'));
    expect(index, contains("window.addEventListener('focus'"));
    expect(index, contains("window.addEventListener('pageshow'"));
    expect(index, contains("window.addEventListener('online'"));
    expect(index, contains("document.addEventListener('visibilitychange'"));
    expect(index, contains('window.location.replace(nextUrl.toString())'));
    expect(index, contains('registration.unregister()'));
    expect(bootstrap, contains('_flutter.loader.load();'));
    expect(bootstrap, isNot(contains('serviceWorkerSettings')));
    expect(headers, contains('/version.json'));
    expect(headers, contains('Cache-Control: no-store'));
  });
}
