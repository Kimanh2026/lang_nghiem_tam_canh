import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vnlunar/vnlunar.dart';

class BuddhistObservance {
  final DateTime solarDate;
  final int lunarDay;
  final int lunarMonth;
  final String title;

  const BuddhistObservance({
    required this.solarDate,
    required this.lunarDay,
    required this.lunarMonth,
    required this.title,
  });
}

class NotificationService {
  NotificationService._();

  static final instance = NotificationService._();
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const dailyEnabledKey = 'daily_reminder_enabled';
  static const observanceEnabledKey = 'observance_reminder_enabled';

  // Các ngày phổ biến trong truyền thống Phật giáo Việt Nam. Phật đản dùng
  // ngày Rằm tháng Tư theo lịch lễ chính thức hiện nay.
  static const _festivalNames = <String, String>{
    '2-8': 'Đức Phật Thích Ca xuất gia',
    '2-15': 'Đức Phật Thích Ca nhập Niết-bàn',
    '2-19': 'Vía Bồ Tát Quán Thế Âm',
    '4-15': 'Đại lễ Phật đản',
    '6-19': 'Vía Bồ Tát Quán Thế Âm thành đạo',
    '7-15': 'Đại lễ Vu Lan',
    '7-30': 'Vía Bồ Tát Địa Tạng',
    '9-19': 'Vía Bồ Tát Quán Thế Âm xuất gia',
    '11-17': 'Vía Đức Phật A Di Đà',
    '12-8': 'Đức Phật Thích Ca thành đạo',
  };

  Future<void> initialize() async {
    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
    );
    await _plugin.initialize(settings: initializationSettings);
  }

  /// Removes schedules created by older app versions without touching any
  /// recitation, profile, chat, or PIN data.
  Future<void> disableLegacyReminders() async {
    await _plugin.cancelAll();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(dailyEnabledKey, false);
    await prefs.setBool(observanceEnabledKey, false);
  }

  List<BuddhistObservance> upcomingObservances({
    int days = 90,
    DateTime? from,
  }) {
    final now = from ?? DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final result = <BuddhistObservance>[];
    for (var offset = 0; offset <= days; offset++) {
      final date = start.add(Duration(days: offset));
      final lunar = convertSolar2Lunar(date.day, date.month, date.year, 7);
      final lunarDay = lunar[0];
      final lunarMonth = lunar[1];
      final isLeapMonth = lunar[3] == 1;
      final tomorrow = date.add(const Duration(days: 1));
      final tomorrowLunar = convertSolar2Lunar(
        tomorrow.day,
        tomorrow.month,
        tomorrow.year,
        7,
      );
      final isShortSeventhMonthEnding =
          !isLeapMonth &&
          lunarMonth == 7 &&
          lunarDay == 29 &&
          tomorrowLunar[0] == 1 &&
          tomorrowLunar[1] == 8;
      final festival = isShortSeventhMonthEnding
          ? 'Vía Bồ Tát Địa Tạng'
          : (isLeapMonth ? null : _festivalNames['$lunarMonth-$lunarDay']);
      final isMonthlyObservance = lunarDay == 1 || lunarDay == 15;
      if (!isMonthlyObservance && festival == null) continue;

      var title =
          festival ??
          (lunarDay == 1 ? 'Ngày mùng 1 âm lịch' : 'Ngày rằm âm lịch');
      if (festival != null && isMonthlyObservance) {
        title = '$festival · ${lunarDay == 1 ? 'Mùng 1' : 'Ngày rằm'}';
      }
      result.add(
        BuddhistObservance(
          solarDate: date,
          lunarDay: lunarDay,
          lunarMonth: lunarMonth,
          title: title,
        ),
      );
    }
    return result;
  }
}
