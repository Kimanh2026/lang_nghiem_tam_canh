import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
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
  static const reminderHourKey = 'reminder_hour';
  static const reminderMinuteKey = 'reminder_minute';

  static const _dailyId = 10;
  static const _observanceIdStart = 1000;

  static const _quotes = <String>[
    'Hôm nay mình dành một thời khóa để trì Chú Lăng Nghiêm nhé.',
    'Một thời trì chú đều đặn mỗi ngày sẽ nuôi lớn tâm tinh tấn.',
    'Đến giờ trở về với thời khóa Chú Lăng Nghiêm của bạn.',
    'Xin nhắc bạn giữ thời khóa hôm nay với tâm trang nghiêm và bền bỉ.',
  ];

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
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh'));

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

  Future<bool> requestPermission() async {
    if (kIsWeb) return false;
    final android = await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
    final ios = await _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
    return android ?? ios ?? true;
  }

  Future<void> applySavedSchedule() async {
    final prefs = await SharedPreferences.getInstance();
    await applySchedule(
      dailyEnabled: prefs.getBool(dailyEnabledKey) ?? false,
      observanceEnabled: prefs.getBool(observanceEnabledKey) ?? false,
      hour: prefs.getInt(reminderHourKey) ?? 20,
      minute: prefs.getInt(reminderMinuteKey) ?? 0,
    );
  }

  Future<void> applySchedule({
    required bool dailyEnabled,
    required bool observanceEnabled,
    required int hour,
    required int minute,
  }) async {
    await _plugin.cancelAll();
    if (kIsWeb) return;
    if (dailyEnabled) await _scheduleDaily(hour, minute);
    if (observanceEnabled) await _scheduleObservances(hour, minute);
  }

  Future<void> showTest() async {
    await _plugin.show(
      id: 99,
      title: 'Lăng Nghiêm Tâm Cảnh',
      body: 'Thông báo đã hoạt động. Chúc bạn giữ thời khóa tinh tấn mỗi ngày.',
      notificationDetails: _details,
    );
  }

  Future<void> _scheduleDaily(int hour, int minute) async {
    final now = tz.TZDateTime.now(tz.local);
    var first = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (!first.isAfter(now)) first = first.add(const Duration(days: 1));

    await _plugin.zonedSchedule(
      id: _dailyId,
      title: 'Đến giờ trì Chú Lăng Nghiêm',
      body: _quotes[Random().nextInt(_quotes.length)],
      scheduledDate: first,
      notificationDetails: _details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'daily-reminder',
    );
  }

  Future<void> _scheduleObservances(int hour, int minute) async {
    final upcoming = upcomingObservances(days: 370);
    for (var i = 0; i < upcoming.length; i++) {
      final item = upcoming[i];
      final when = tz.TZDateTime(
        tz.local,
        item.solarDate.year,
        item.solarDate.month,
        item.solarDate.day,
        hour,
        minute,
      );
      if (!when.isAfter(tz.TZDateTime.now(tz.local))) continue;
      await _plugin.zonedSchedule(
        id: _observanceIdStart + i,
        title: item.title,
        body:
            'Hôm nay là ${item.lunarDay}/${item.lunarMonth} âm lịch. '
            'Xin nhắc bạn dành thời gian tu tập và trì chú.',
        scheduledDate: when,
        notificationDetails: _details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        payload: 'buddhist-observance',
      );
    }
  }

  List<BuddhistObservance> upcomingObservances({int days = 90}) {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final result = <BuddhistObservance>[];
    for (var offset = 0; offset <= days; offset++) {
      final date = start.add(Duration(days: offset));
      final lunar = convertSolar2Lunar(date.day, date.month, date.year, 7);
      final lunarDay = lunar[0];
      final lunarMonth = lunar[1];
      final isLeapMonth = lunar[3] == 1;
      final festival = isLeapMonth
          ? null
          : _festivalNames['$lunarMonth-$lunarDay'];
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

  NotificationDetails get _details => const NotificationDetails(
    android: AndroidNotificationDetails(
      'practice_reminders',
      'Nhắc thời khóa và ngày Phật giáo',
      channelDescription:
          'Nhắc trì Chú Lăng Nghiêm và những ngày Phật giáo quan trọng',
      importance: Importance.high,
      priority: Priority.high,
    ),
    iOS: DarwinNotificationDetails(),
  );
}
