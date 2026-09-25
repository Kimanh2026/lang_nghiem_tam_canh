import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/home_screen.dart';
import 'screens/teachings_screen.dart';
import 'screens/mantra_screen.dart';
import 'screens/ai_coach_screen.dart';
import 'screens/pin_screen.dart';
import 'screens/settings_screen.dart';
import 'services/notification_service.dart';
import 'theme/app_palette.dart';
import 'widgets/app_background.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Notification support must never block the app from opening on mobile web.
  // Older installed PWAs can expose a partially available notification API.
  try {
    await NotificationService.instance.initialize().timeout(
      const Duration(seconds: 3),
    );
    await NotificationService.instance.disableLegacyReminders().timeout(
      const Duration(seconds: 3),
    );
  } catch (error) {
    debugPrint('Notification startup skipped: $error');
  }

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
        scaffoldBackgroundColor: Colors.transparent,
        cardColor: AppPalette.glassPanel,
        primaryColor: const Color(0xFFD4AF37),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFD4AF37),
          secondary: Color(0xFFF28C28),
          surface: AppPalette.glassPanel,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: AppPalette.primaryText,
            fontWeight: FontWeight.w500,
            shadows: AppPalette.readableTextShadow,
          ),
          bodyMedium: TextStyle(
            color: AppPalette.primaryText,
            fontWeight: FontWeight.w500,
            shadows: AppPalette.readableTextShadow,
          ),
          bodySmall: TextStyle(
            color: AppPalette.secondaryText,
            fontWeight: FontWeight.w500,
            shadows: AppPalette.readableTextShadow,
          ),
          titleLarge: TextStyle(
            color: AppPalette.primaryText,
            fontWeight: FontWeight.w600,
            shadows: AppPalette.readableTextShadow,
          ),
          titleMedium: TextStyle(
            color: AppPalette.primaryText,
            fontWeight: FontWeight.w600,
            shadows: AppPalette.readableTextShadow,
          ),
          titleSmall: TextStyle(
            color: AppPalette.secondaryText,
            fontWeight: FontWeight.w600,
            shadows: AppPalette.readableTextShadow,
          ),
          labelLarge: TextStyle(
            color: AppPalette.primaryText,
            fontWeight: FontWeight.w600,
          ),
          labelMedium: TextStyle(
            color: AppPalette.secondaryText,
            fontWeight: FontWeight.w600,
            shadows: AppPalette.readableTextShadow,
          ),
          labelSmall: TextStyle(
            color: AppPalette.secondaryText,
            fontWeight: FontWeight.w600,
            shadows: AppPalette.readableTextShadow,
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            foregroundColor: const Color(0xFF1B2D38),
            textStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              shadows: <Shadow>[],
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: const Color(0xFF1B2D38),
            textStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              shadows: <Shadow>[],
            ),
          ),
        ),
        useMaterial3: true,
      ),
      builder: (context, child) =>
          AppBackground(child: child ?? const SizedBox.shrink()),
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
            opacity: selected ? 1 : 0.88,
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
      decoration: const BoxDecoration(color: Colors.transparent),
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
                                  ? AppPalette.menuSelectedText
                                  : AppPalette.menuText,
                              fontSize: compact ? 14 : 16,
                              fontWeight: FontWeight.w900,
                              shadows: AppPalette.crispTextShadow,
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
                  padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: const Color(0x24FFFFFF),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0x66FFFFFF)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x33000000),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
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
                                        fontSize: 11,
                                        fontWeight: FontWeight.w800,
                                        color: selected
                                            ? AppPalette.menuSelectedText
                                            : AppPalette.menuText,
                                        shadows: AppPalette.crispTextShadow,
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
