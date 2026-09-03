import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/notification_service.dart';
import 'privacy_policy_screen.dart';

class SettingsScreen extends StatefulWidget {
  final ValueNotifier<String> userName;
  final ValueNotifier<int> clearChatTrigger;
  const SettingsScreen({
    super.key,
    required this.userName,
    required this.clearChatTrigger,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final TextEditingController _nameController;
  bool _dailyEnabled = false;
  bool _observanceEnabled = false;
  TimeOfDay _reminderTime = const TimeOfDay(hour: 20, minute: 0);

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userName.value);
    _loadReminderSettings();
  }

  Future<void> _loadReminderSettings() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _dailyEnabled =
          prefs.getBool(NotificationService.dailyEnabledKey) ?? false;
      _observanceEnabled =
          prefs.getBool(NotificationService.observanceEnabledKey) ?? false;
      _reminderTime = TimeOfDay(
        hour: prefs.getInt(NotificationService.reminderHourKey) ?? 20,
        minute: prefs.getInt(NotificationService.reminderMinuteKey) ?? 0,
      );
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveName() {
    widget.userName.value = _nameController.text.trim();
    _showMessage('Đã lưu tên thành công.');
  }

  Future<void> _setReminder({bool? daily, bool? observance}) async {
    final nextDaily = daily ?? _dailyEnabled;
    final nextObservance = observance ?? _observanceEnabled;
    if ((nextDaily || nextObservance) && kIsWeb) {
      _showMessage(
        'Thông báo nền cần bản Android APK. Bản cài từ trình duyệt có thể bị hệ điều hành hạn chế.',
      );
    } else if ((nextDaily || nextObservance) &&
        !await NotificationService.instance.requestPermission()) {
      _showMessage('Bạn cần cho phép thông báo trong cài đặt điện thoại.');
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(NotificationService.dailyEnabledKey, nextDaily);
    await prefs.setBool(
      NotificationService.observanceEnabledKey,
      nextObservance,
    );
    await NotificationService.instance.applySchedule(
      dailyEnabled: nextDaily,
      observanceEnabled: nextObservance,
      hour: _reminderTime.hour,
      minute: _reminderTime.minute,
    );
    if (!mounted) return;
    setState(() {
      _dailyEnabled = nextDaily;
      _observanceEnabled = nextObservance;
    });
  }

  Future<void> _pickReminderTime() async {
    final selected = await showTimePicker(
      context: context,
      initialTime: _reminderTime,
      helpText: 'CHỌN GIỜ NHẮC HẰNG NGÀY',
      cancelText: 'Hủy',
      confirmText: 'Lưu',
    );
    if (selected == null || !mounted) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(NotificationService.reminderHourKey, selected.hour);
    await prefs.setInt(NotificationService.reminderMinuteKey, selected.minute);
    setState(() => _reminderTime = selected);
    await NotificationService.instance.applySchedule(
      dailyEnabled: _dailyEnabled,
      observanceEnabled: _observanceEnabled,
      hour: selected.hour,
      minute: selected.minute,
    );
    if (mounted)
      _showMessage('Đã đổi giờ nhắc sang ${selected.format(context)}.');
  }

  Future<void> _testNotification() async {
    if (kIsWeb) {
      _showMessage(
        'Hãy dùng bản Android APK để thử thông báo khi ứng dụng đã đóng.',
      );
      return;
    }
    if (!await NotificationService.instance.requestPermission()) {
      _showMessage('Bạn chưa cho phép ứng dụng gửi thông báo.');
      return;
    }
    await NotificationService.instance.showTest();
    _showMessage('Đã gửi một thông báo thử.');
  }

  void _showInstallGuide() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF2D1A11),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 20, 22, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Row(
                children: [
                  Icon(Icons.install_mobile, color: Color(0xFFD4AF37)),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Cài Lăng Nghiêm Tâm Cảnh',
                      style: TextStyle(
                        color: Color(0xFFD4AF37),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _guideBlock(
                'Android — dễ và đầy đủ nhất',
                'Mở trang app bằng Chrome → mở trình đơn ba chấm → chọn “Cài đặt ứng dụng” hoặc “Thêm vào màn hình chính” → xác nhận Cài đặt.\n\nĐể nhận nhắc ổn định khi đã đóng app, hãy cài bản APK Android do tác giả cung cấp rồi cho phép Thông báo.',
              ),
              const SizedBox(height: 14),
              _guideBlock(
                'iPhone / iPad',
                'Mở trang app bằng Safari → bấm biểu tượng Chia sẻ → “Thêm vào Màn hình chính” → bật “Mở dưới dạng ứng dụng web” → bấm Thêm.',
              ),
              const SizedBox(height: 14),
              const Text(
                'Lưu ý: biểu tượng ngoài màn hình và giao diện toàn màn hình hoạt động như app. Tuy nhiên iPhone và một số trình duyệt có thể hạn chế thông báo chạy nền.',
                style: TextStyle(color: Colors.white60, height: 1.45),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _guideBlock(String title, String body) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF1A0D08),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0x33D4AF37)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(body, style: const TextStyle(color: Colors.white70, height: 1.45)),
      ],
    ),
  );

  void _confirmClearChat() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2D1A11),
        title: const Text(
          'Xác nhận xóa',
          style: TextStyle(color: Color(0xFFD4AF37)),
        ),
        content: const Text(
          'Bạn có chắc chắn muốn xóa toàn bộ lịch sử trò chuyện với Tiểu Tịnh không?',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy', style: TextStyle(color: Colors.white54)),
          ),
          TextButton(
            onPressed: () {
              widget.clearChatTrigger.value += 1;
              Navigator.pop(context);
              _showMessage('Đã xóa lịch sử trò chuyện.');
            },
            child: const Text('Xóa', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Color(0xFF1A0D08)),
        ),
        backgroundColor: const Color(0xFFD4AF37),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final upcoming = NotificationService.instance
        .upcomingObservances(days: 90)
        .take(5)
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cài Đặt',
          style: TextStyle(
            color: Color(0xFFD4AF37),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: const Color(0xFF1A0D08),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: const Color(0x33D4AF37), height: 1),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('CÀI ỨNG DỤNG'),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.install_mobile,
                  color: Color(0xFFD4AF37),
                ),
                title: const Text('Hướng dẫn cài trên điện thoại'),
                subtitle: const Text(
                  'Xem hướng dẫn cho Android và iPhone',
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.white54,
                ),
                onTap: _showInstallGuide,
              ),
            ),
            const SizedBox(height: 28),
            _sectionTitle('NHẮC THỜI KHÓA'),
            const SizedBox(height: 12),
            Card(
              child: Column(
                children: [
                  SwitchListTile(
                    secondary: const Icon(
                      Icons.notifications_active_outlined,
                      color: Color(0xFFD4AF37),
                    ),
                    title: const Text('Nhắc trì chú mỗi ngày'),
                    subtitle: const Text(
                      'Theo giờ bạn chọn',
                      style: TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                    value: _dailyEnabled,
                    onChanged: (value) => _setReminder(daily: value),
                  ),
                  const Divider(color: Color(0x1AD4AF37), height: 1),
                  ListTile(
                    leading: const Icon(
                      Icons.schedule,
                      color: Color(0xFFD4AF37),
                    ),
                    title: const Text('Giờ nhắc'),
                    subtitle: Text(
                      _reminderTime.format(context),
                      style: const TextStyle(color: Colors.white54),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.white54,
                    ),
                    onTap: _pickReminderTime,
                  ),
                  const Divider(color: Color(0x1AD4AF37), height: 1),
                  SwitchListTile(
                    secondary: const Icon(
                      Icons.event_available,
                      color: Color(0xFFD4AF37),
                    ),
                    title: const Text('Nhắc ngày Phật giáo'),
                    subtitle: const Text(
                      'Mùng 1, ngày rằm và các ngày lễ, ngày vía chính',
                      style: TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                    value: _observanceEnabled,
                    onChanged: (value) => _setReminder(observance: value),
                  ),
                  const Divider(color: Color(0x1AD4AF37), height: 1),
                  ListTile(
                    leading: const Icon(
                      Icons.notification_add_outlined,
                      color: Color(0xFFD4AF37),
                    ),
                    title: const Text('Gửi thông báo thử'),
                    onTap: _testNotification,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Các ngày sắp tới',
                      style: TextStyle(
                        color: Color(0xFFD4AF37),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    for (final item in upcoming)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 9),
                        child: Text(
                          '${item.solarDate.day.toString().padLeft(2, '0')}/${item.solarDate.month.toString().padLeft(2, '0')}/${item.solarDate.year}  ·  ${item.title}',
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),
            _sectionTitle('THÔNG TIN CÁ NHÂN'),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Tên để Tiểu Tịnh gọi bạn',
                          filled: true,
                          fillColor: Color(0xFF1A0D08),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    FilledButton(
                      onPressed: _saveName,
                      child: const Text('Lưu'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),
            _sectionTitle('TÙY CHỌN'),
            const SizedBox(height: 12),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.delete_outline,
                      color: Colors.redAccent,
                    ),
                    title: const Text('Xóa lịch sử trò chuyện'),
                    subtitle: const Text(
                      'Xóa sạch tin nhắn với Tiểu Tịnh',
                      style: TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                    onTap: _confirmClearChat,
                  ),
                  const Divider(color: Color(0x1AD4AF37), height: 1),
                  ListTile(
                    leading: const Icon(
                      Icons.privacy_tip_outlined,
                      color: Color(0xFFD4AF37),
                    ),
                    title: const Text('Chính Sách Bảo Mật'),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.white54,
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PrivacyPolicyScreen(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) => Text(
    text,
    style: const TextStyle(
      color: Color(0xFFD4AF37),
      fontWeight: FontWeight.bold,
      fontSize: 14,
      letterSpacing: 1,
    ),
  );
}
