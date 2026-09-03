import 'package:flutter_test/flutter_test.dart';
import 'package:lang_nghiem_tam_canh/services/notification_service.dart';
import 'package:vnlunar/vnlunar.dart';

void main() {
  test('Vietnamese lunar conversion matches the package reference example', () {
    expect(convertSolar2Lunar(23, 3, 2023, 7), [2, 2, 2023, 1]);
  });

  test('upcoming observances are sorted and contain monthly observances', () {
    final items = NotificationService.instance.upcomingObservances(days: 90);
    expect(items, isNotEmpty);
    expect(items.any((item) => item.lunarDay == 1), isTrue);
    expect(items.any((item) => item.lunarDay == 15), isTrue);
    for (var i = 1; i < items.length; i++) {
      expect(items[i].solarDate.isBefore(items[i - 1].solarDate), isFalse);
    }
  });

  test('Dia Tang observance is present in each upcoming lunar year', () {
    final items = NotificationService.instance.upcomingObservances(days: 730);
    final diaTangDays = items
        .where((item) => item.title.contains('Địa Tạng'))
        .toList();
    expect(diaTangDays.length, greaterThanOrEqualTo(2));
    expect(diaTangDays.every((item) => item.lunarMonth == 7), isTrue);
    expect(
      diaTangDays.every((item) => item.lunarDay == 29 || item.lunarDay == 30),
      isTrue,
    );
  });
}
