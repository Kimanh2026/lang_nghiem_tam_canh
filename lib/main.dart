import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:math';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'screens/home_screen.dart';
import 'screens/teachings_screen.dart';
import 'screens/mantra_screen.dart';
import 'screens/ai_coach_screen.dart';
import 'screens/pin_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/about_author_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print("No .env file found. Using fallback keys.");
  }
  
  tz.initializeTimeZones();
  
  final prefs = await SharedPreferences.getInstance();
  final int initialCount = prefs.getInt('recitationCount') ?? 0; // Each new user starts from 0
  final ValueNotifier<int> globalRecitationCount = ValueNotifier<int>(initialCount);
  final String? savedPin = prefs.getString('app_pin');
  
  // Settings state
  final String initialName = prefs.getString('user_name') ?? '';
  final ValueNotifier<String> globalUserName = ValueNotifier<String>(initialName);
  final ValueNotifier<int> globalClearChatTrigger = ValueNotifier<int>(0);

  // Store in shared preferences whenever it changes
  globalRecitationCount.addListener(() async {
    final prefsInstance = await SharedPreferences.getInstance();
    await prefsInstance.setInt('recitationCount', globalRecitationCount.value);
  });
  globalUserName.addListener(() async {
    final prefsInstance = await SharedPreferences.getInstance();
    await prefsInstance.setString('user_name', globalUserName.value);
  });

  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  // For web, notifications will degrade gracefully or do nothing if not supported properly.
  const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(settings: initializationSettings);
  
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestExactAlarmsPermission();
  
  _scheduleDailyReminder();

  runApp(LangNghiemApp(
    recitationCount: globalRecitationCount, 
    savedPin: savedPin,
    userName: globalUserName,
    clearChatTrigger: globalClearChatTrigger,
  ));
}

void _scheduleDailyReminder() async {
  final List<String> quotes = [
    "Hãy tinh tấn tu tập, thời gian không chờ đợi ai. - Hòa Thượng Tuyên Hóa",
    "Trì Chú Lăng Nghiêm là gieo hạt giống thành Phật. - Hòa Thượng Tuyên Hóa",
    "Nghiệp chướng càng nặng, càng phải nỗ lực trì chú. - Hòa Thượng Phổ Quang",
    "Có Chú Lăng Nghiêm là có chánh pháp. - Hòa Thượng Tuyên Hóa"
  ];
  final randomQuote = quotes[Random().nextInt(quotes.length)];

  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
    'daily_reminder_channel', 'Daily Reminders',
    channelDescription: 'Daily encouraging reminders',
    importance: Importance.max, priority: Priority.high,
  );
  var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

  tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, 21, 0);
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }

  try {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id: 0,
      title: 'Lăng Nghiêm Tâm Cảnh',
      body: randomQuote,
      scheduledDate: scheduledDate,
      notificationDetails: platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  } catch (e) {
    // Ignore notification errors on unsupported platforms like Web
  }
}

// Global method to trigger a test notification for the user to verify
void triggerTestNotification() async {
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
    'test_channel', 'Test Notifications',
    importance: Importance.max, priority: Priority.high,
  );
  var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
  try {
    await flutterLocalNotificationsPlugin.show(
      id: 1,
      title: 'Lăng Nghiêm Tâm Cảnh',
      body: 'Thử nghiệm: Hãy tiếp tục tinh tấn trì chú! - Hòa Thượng Tuyên Hóa',
      notificationDetails: platformChannelSpecifics,
    );
  } catch (e) {
    // Ignore
  }
}

class LangNghiemApp extends StatelessWidget {
  final ValueNotifier<int> recitationCount;
  final String? savedPin;
  final ValueNotifier<String> userName;
  final ValueNotifier<int> clearChatTrigger;
  
  const LangNghiemApp({
    super.key, 
    required this.recitationCount, 
    this.savedPin,
    required this.userName,
    required this.clearChatTrigger,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lang Nghiem Tam Canh',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1A0D08),
        cardColor: const Color(0xFF2D1A11),
        primaryColor: const Color(0xFFD4AF37),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFD4AF37),
          secondary: Color(0xFFF28C28),
          surface: Color(0xFF2D1A11),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFFFDF5E6)),
          bodyMedium: TextStyle(color: Color(0xFFFDF5E6)),
        ),
        useMaterial3: true,
      ),
      routes: {
        '/home': (context) => MainScaffold(
          recitationCount: recitationCount,
          userName: userName,
          clearChatTrigger: clearChatTrigger,
        ),
      },
      home: PinScreen(savedPin: savedPin, recitationCount: recitationCount),
    );
  }
}

class MainScaffold extends StatefulWidget {
  final ValueNotifier<int> recitationCount;
  final ValueNotifier<String> userName;
  final ValueNotifier<int> clearChatTrigger;

  const MainScaffold({
    super.key, 
    required this.recitationCount,
    required this.userName,
    required this.clearChatTrigger,
  });

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  static const double _compactRailBreakpoint = 800;

  static const _railDestinations = <NavigationRailDestination>[
    NavigationRailDestination(icon: Icon(Icons.home), label: Text('Trang chủ')),
    NavigationRailDestination(
      icon: Icon(Icons.menu_book),
      label: Text('Khai thị'),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.self_improvement),
      label: Text('Trì chú'),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.chat_bubble),
      label: Text('Tiểu Tịnh'),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.info_outline),
      label: Text('Tác Giả'),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.settings),
      label: Text('Cài đặt'),
    ),
  ];

  int _currentIndex = 0;

  void _switchTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isCompactRail =
        MediaQuery.sizeOf(context).width < _compactRailBreakpoint;
    final screens = [
      HomeScreen(recitationCount: widget.recitationCount, onStartChanting: () => _switchTab(2)),
      const TeachingsScreen(),
      MantraScreen(recitationCount: widget.recitationCount),
      AiCoachScreen(userName: widget.userName, clearChatTrigger: widget.clearChatTrigger),
      const AboutAuthorScreen(),
      SettingsScreen(userName: widget.userName, clearChatTrigger: widget.clearChatTrigger),
    ];

    final content = IndexedStack(index: _currentIndex, children: screens);

    return Scaffold(
      body: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(color: Color(0x33D4AF37), width: 1),
              ),
            ),
            child: SafeArea(
              child: NavigationRail(
                selectedIndex: _currentIndex,
                onDestinationSelected: _switchTab,
                extended: true,
                minWidth: isCompactRail ? 56 : 72,
                minExtendedWidth: isCompactRail ? 128 : 200,
                groupAlignment: -0.85,
                backgroundColor: const Color(0xFF2D1A11),
                selectedIconTheme: IconThemeData(
                  color: const Color(0xFFD4AF37),
                  size: isCompactRail ? 20 : 24,
                ),
                unselectedIconTheme: IconThemeData(
                  color: const Color(0xFFD1BFAE),
                  size: isCompactRail ? 20 : 24,
                ),
                selectedLabelTextStyle: TextStyle(
                  color: const Color(0xFFD4AF37),
                  fontSize: isCompactRail ? 11 : 14,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelTextStyle: TextStyle(
                  color: const Color(0xFFD1BFAE),
                  fontSize: isCompactRail ? 11 : 14,
                ),
                destinations: _railDestinations,
              ),
            ),
          ),
          Expanded(child: content),
        ],
      ),
    );
  }
}
