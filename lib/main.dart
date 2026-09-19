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
import 'services/notification_service.dart';
import 'release_notes.dart';
import 'widgets/app_background.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print("No .env file found. Using fallback keys.");
  }

  await NotificationService.instance.initialize();
  await NotificationService.instance.disableLegacyReminders();

  final prefs = await SharedPreferences.getInstance();
  final int initialCount =
      prefs.getInt('recitationCount') ?? 0; // Each new user starts from 0
  final ValueNotifier<int> globalRecitationCount = ValueNotifier<int>(
    initialCount,
  );
  final String? savedPin = prefs.getString('app_pin');
  final bool showUpdateAnnouncement = AppReleaseNotes.shouldAnnounce(
    prefs.getString(AppReleaseNotes.seenVersionKey),
  );

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

  runApp(
    LangNghiemApp(
      recitationCount: globalRecitationCount,
      savedPin: savedPin,
      userName: globalUserName,
      clearChatTrigger: globalClearChatTrigger,
      showUpdateAnnouncement: showUpdateAnnouncement,
    ),
  );
}

class LangNghiemApp extends StatelessWidget {
  final ValueNotifier<int> recitationCount;
  final String? savedPin;
  final ValueNotifier<String> userName;
  final ValueNotifier<int> clearChatTrigger;
  final bool showUpdateAnnouncement;

  const LangNghiemApp({
    super.key,
    required this.recitationCount,
    this.savedPin,
    required this.userName,
    required this.clearChatTrigger,
    this.showUpdateAnnouncement = false,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lang Nghiem Tam Canh',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.transparent,
        cardColor: const Color(0xE6253944),
        primaryColor: const Color(0xFFD4AF37),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFD4AF37),
          secondary: Color(0xFFF28C28),
          surface: Color(0xE6253944),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFFFDF5E6)),
          bodyMedium: TextStyle(color: Color(0xFFFDF5E6)),
        ),
        useMaterial3: true,
      ),
      builder: (context, child) => AppBackground(
        child: child ?? const SizedBox.shrink(),
      ),
      routes: {
        '/home': (context) => MainScaffold(
          recitationCount: recitationCount,
          userName: userName,
          clearChatTrigger: clearChatTrigger,
          showUpdateAnnouncement: showUpdateAnnouncement,
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
  final bool showUpdateAnnouncement;

  const MainScaffold({
    super.key,
    required this.recitationCount,
    required this.userName,
    required this.clearChatTrigger,
    this.showUpdateAnnouncement = false,
  });

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _LuxuryNavIcon extends StatelessWidget {
  final String asset;
  final String label;
  final bool selected;

  const _LuxuryNavIcon({
    required this.asset,
    required this.label,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      image: true,
      label: selected ? '$label, đang chọn' : label,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        offset: selected ? const Offset(0, -0.08) : Offset.zero,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutBack,
          scale: selected ? 1.12 : 1,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 180),
            opacity: selected ? 1 : 0.66,
            child: SizedBox(
              key: ValueKey(
                'nav-${asset.split('/').last.replaceFirst('nav-', '').replaceFirst('.png', '')}-${selected ? 'selected' : 'idle'}',
              ),
              width: 48,
              height: 42,
              child: Image.asset(
                asset,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MainScaffoldState extends State<MainScaffold> {
  static const double _compactRailBreakpoint = 800;

  @override
  void initState() {
    super.initState();
    if (widget.showUpdateAnnouncement) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _announceCurrentRelease();
      });
    }
  }

  Future<void> _announceCurrentRelease() async {
    if (!mounted) return;
    await showCurrentReleaseNotes(context);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      AppReleaseNotes.seenVersionKey,
      AppReleaseNotes.version,
    );
  }

  static const _railDestinations = <NavigationRailDestination>[
    NavigationRailDestination(
      icon: _LuxuryNavIcon(
        asset: 'assets/icons/nav-home.png',
        label: 'Trang chủ',
      ),
      selectedIcon: _LuxuryNavIcon(
        asset: 'assets/icons/nav-home.png',
        label: 'Trang chủ',
        selected: true,
      ),
      label: Text('Trang chủ'),
    ),
    NavigationRailDestination(
      icon: _LuxuryNavIcon(
        asset: 'assets/icons/nav-teachings.png',
        label: 'Khai thị',
      ),
      selectedIcon: _LuxuryNavIcon(
        asset: 'assets/icons/nav-teachings.png',
        label: 'Khai thị',
        selected: true,
      ),
      label: Text('Khai thị'),
    ),
    NavigationRailDestination(
      icon: _LuxuryNavIcon(
        asset: 'assets/icons/nav-mantra.png',
        label: 'Trì chú',
      ),
      selectedIcon: _LuxuryNavIcon(
        asset: 'assets/icons/nav-mantra.png',
        label: 'Trì chú',
        selected: true,
      ),
      label: Text('Trì chú'),
    ),
    NavigationRailDestination(
      icon: _LuxuryNavIcon(
        asset: 'assets/icons/nav-chat.png',
        label: 'Tiểu Tịnh',
      ),
      selectedIcon: _LuxuryNavIcon(
        asset: 'assets/icons/nav-chat.png',
        label: 'Tiểu Tịnh',
        selected: true,
      ),
      label: Text('Tiểu Tịnh'),
    ),
    NavigationRailDestination(
      icon: _LuxuryNavIcon(
        asset: 'assets/icons/nav-settings.png',
        label: 'Cài đặt',
      ),
      selectedIcon: _LuxuryNavIcon(
        asset: 'assets/icons/nav-settings.png',
        label: 'Cài đặt',
        selected: true,
      ),
      label: Text('Cài đặt'),
    ),
  ];

  int _currentIndex = 0;

  void _switchTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _buildDesktopNavigation({required bool compact}) {
    return Container(
      key: const Key('desktop-navigation'),
      width: compact ? 174 : 190,
      decoration: const BoxDecoration(
        color: Color(0xE6253944),
        border: Border(right: BorderSide(color: Color(0x33D4AF37), width: 1)),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(compact ? 12 : 16, 14, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(_railDestinations.length, (index) {
              final selected = _currentIndex == index;
              final destination = _railDestinations[index];
              return SizedBox(
                key: ValueKey('desktop-nav-item-$index'),
                height: 58,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () => _switchTab(index),
                    child: Row(
                      children: [
                        SizedBox(
                          key: ValueKey('desktop-nav-icon-slot-$index'),
                          width: 48,
                          height: 42,
                          child: Center(
                            child: selected
                                ? destination.selectedIcon
                                : destination.icon,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: DefaultTextStyle(
                            style: TextStyle(
                              color: selected
                                  ? const Color(0xFFF4D35E)
                                  : const Color(0xFFF4E9DC),
                              fontSize: compact ? 14 : 16,
                              fontWeight: selected
                                  ? FontWeight.w800
                                  : FontWeight.w500,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: destination.label,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
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
                      color: const Color(0xE6253944),
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
                                  vertical: 8,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    selected
                                        ? destination.selectedIcon
                                        : destination.icon,
                                    const SizedBox(height: 3),
                                    DefaultTextStyle(
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: selected
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: selected
                                            ? const Color(0xFFD4AF37)
                                            : const Color(0xFFF4E9DC),
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
          _buildDesktopNavigation(compact: isCompactRail),
          Expanded(child: content),
        ],
      ),
    );
  }
}
