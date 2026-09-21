import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('browser app calls proxy without embedding Gemini credentials', () {
    final screen = File('lib/screens/ai_coach_screen.dart').readAsStringSync();
    final main = File('lib/main.dart').readAsStringSync();
    final worker = File('cloudflare-worker/worker.js').readAsStringSync();

    expect(screen, contains('lang-nghiem-tieu-tinh.nkimanh932.workers.dev'));
    expect(screen, isNot(contains('google_generative_ai')));
    expect(screen, isNot(contains('GEMINI_API_KEY')));
    expect(screen, isNot(contains(RegExp(r'AQ\.[A-Za-z0-9_-]{20,}'))));
    expect(main, isNot(contains('flutter_dotenv')));
    expect(worker, contains('env.GEMINI_API_KEY'));
    expect(worker, contains('gemini-3-flash-preview:generateContent'));
    expect(worker, contains('https://kimanh2026.github.io'));
    expect(worker, isNot(contains(RegExp(r'AQ\.[A-Za-z0-9_-]{20,}'))));
  });
}
