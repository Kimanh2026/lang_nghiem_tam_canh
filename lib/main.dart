import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'screens/home_screen.dart';
import 'screens/teachings_screen.dart';
import 'screens/mantra_screen.dart';
import 'screens/ai_coach_screen.dart';
import 'screens/pin_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/about_author_screen.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print("No .env file found. Using fallback keys.");
  }

  await NotificationService.instance.initialize();

  final prefs = await SharedPreferences.getInstance();
  final int initialCount =
      prefs.getInt('recitationCount') ?? 0; // Each new user starts from 0
  final ValueNotifier<int> globalRecitationCount = ValueNotifier<int>(
    initialCount,
  );
  final String? savedPin = prefs.getString('app_pin');

  // Settings state
  final String initialName = prefs.getString('user_name') ?? '';
  final ValueNotifier<String> globalUserName = ValueNotifier<String>(
    initialName,
  );
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

  await NotificationService.instance.applySavedSchedule();

  runApp(
    LangNghiemApp(
      recitationCount: globalRecitationCount,
      savedPin: savedPin,
      userName: globalUserName,
      clearChatTrigger: globalClearChatTrigger,
    ),
  );
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
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isPhone = screenWidth < 600;
    final isCompactRail = screenWidth < _compactRailBreakpoint;
    final screens = [
      HomeScreen(
        recitationCount: widget.recitationCount,
        onStartChanting: () => _switchTab(2),
      ),
      const TeachingsScreen(),
      MantraScreen(recitationCount: widget.recitationCount),
      AiCoachScreen(
        userName: widget.userName,
        clearChatTrigger: widget.clearChatTrigger,
      ),
      const AboutAuthorScreen(),
      SettingsScreen(
        userName: widget.userName,
        clearChatTrigger: widget.clearChatTrigger,
      ),
    ];

    final content = IndexedStack(index: _currentIndex, children: screens);

    if (isPhone) {
      return Scaffold(
        body: SafeArea(bottom: false, child: content),
        bottomNavigationBar: MediaQuery.viewInsetsOf(context).bottom > 0
            ? null
            : SafeArea(
                top: false,
                child: Padding(
                  // Leave room for the hosting badge without covering controls.
                  padding: const EdgeInsets.fromLTRB(8, 6, 8, kIsWeb ? 56 : 8),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D1A11),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0x33D4AF37)),
                    ),
                    child: Row(
                      children: List.generate(_railDestinations.length, (
                        index,
                      ) {
                        final selected = _currentIndex == index;
                        final destination = _railDestinations[index];
                        return Expanded(
                          child: Semantics(
                            selected: selected,
                            button: true,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(22),
                              onTap: () => _switchTab(index),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconTheme(
                                      data: IconThemeData(
                                        size: 23,
                                        color: selected
                                            ? const Color(0xFFD4AF37)
                                            : const Color(0xFFD1BFAE),
                                      ),
                                      child: destination.icon,
                                    ),
                                    const SizedBox(height: 5),
                                    DefaultTextStyle(
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: selected
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: selected
                                            ? const Color(0xFFD4AF37)
                                            : const Color(0xFFD1BFAE),
                                      ),
                                      child: destination.label,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
      );
    }

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
                extended: !isPhone,
                labelType: isPhone
                    ? NavigationRailLabelType.all
                    : NavigationRailLabelType.none,
                minWidth: isPhone ? 72 : (isCompactRail ? 128 : 200),
                minExtendedWidth: isCompactRail ? 128 : 200,
                groupAlignment: -0.85,
                backgroundColor: const Color(0xFF2D1A11),
                selectedIconTheme: IconThemeData(
                  color: const Color(0xFFD4AF37),
                  size: isPhone ? 24 : (isCompactRail ? 22 : 26),
                ),
                unselectedIconTheme: IconThemeData(
                  color: const Color(0xFFD1BFAE),
                  size: isPhone ? 24 : (isCompactRail ? 22 : 26),
                ),
                selectedLabelTextStyle: TextStyle(
                  color: const Color(0xFFD4AF37),
                  fontSize: isPhone ? 10 : (isCompactRail ? 14 : 16),
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelTextStyle: TextStyle(
                  color: const Color(0xFFD1BFAE),
                  fontSize: isPhone ? 10 : (isCompactRail ? 14 : 16),
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
