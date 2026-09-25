import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/mantra_text.dart';
import '../data/sanskrit_mantra_text.dart';
import '../theme/app_palette.dart';
import '../widgets/scroll_away_page.dart';

class MantraScreen extends StatefulWidget {
  final ValueNotifier<int> recitationCount;

  const MantraScreen({super.key, required this.recitationCount});

  @override
  State<MantraScreen> createState() => _MantraScreenState();
}

class _MantraScreenState extends State<MantraScreen> {
  final int _goal = 36000;
  int _selectedMantraTab = 0;

  Widget _mantraTab({
    required int index,
    required String label,
    required bool isPhone,
  }) {
    final selected = _selectedMantraTab == index;
    return Expanded(
      child: InkWell(
        key: Key('mantra-tab-$index'),
        borderRadius: BorderRadius.circular(12),
        onTap: () => setState(() => _selectedMantraTab = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: EdgeInsets.symmetric(
            horizontal: isPhone ? 6 : 14,
            vertical: isPhone ? 10 : 12,
          ),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFFD4AF37) : Colors.white10,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? const Color(0xFFF4D35E) : Colors.white24,
            ),
          ),
          child: Text(
            label,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected ? const Color(0xFF1B2D38) : Colors.white,
              fontSize: isPhone ? 12.5 : 14,
              fontWeight: FontWeight.w800,
              height: 1.15,
            ),
          ),
        ),
      ),
    );
  }

  Widget _sanskritTextCard({required String title, required String content}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0x33D4AF37)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFFF4D35E),
              fontSize: 18,
              fontWeight: FontWeight.w800,
              height: 1.35,
              shadows: AppPalette.readableTextShadow,
            ),
          ),
          const SizedBox(height: 14),
          SelectableText(
            content,
            style: const TextStyle(
              color: AppPalette.primaryText,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 1.72,
              shadows: AppPalette.readableTextShadow,
            ),
          ),
        ],
      ),
    );
  }

  void _incrementCount() async {
    widget.recitationCount.value++;
    _checkAchievements(widget.recitationCount.value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('recitationCount', widget.recitationCount.value);
  }

  void _decrementCount() async {
    if (widget.recitationCount.value > 0) {
      widget.recitationCount.value--;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('recitationCount', widget.recitationCount.value);
    }
  }

  void _showEditCountDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController(
      text: widget.recitationCount.value.toString(),
    );
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppPalette.glassPanel,
          title: const Text(
            'Điều chỉnh tiến độ',
            style: TextStyle(color: Color(0xFFD4AF37)),
          ),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Nhập số biến đã trì',
              hintStyle: TextStyle(
                color: AppPalette.mutedText,
                fontWeight: FontWeight.w600,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFD4AF37)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFD4AF37)),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Hủy',
                style: TextStyle(
                  color: AppPalette.mutedText,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                final newValue = int.tryParse(controller.text);
                if (newValue != null && newValue >= 0) {
                  widget.recitationCount.value = newValue;
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setInt('recitationCount', newValue);
                }
                Navigator.pop(context);
              },
              child: const Text(
                'Lưu',
                style: TextStyle(color: Color(0xFFD4AF37)),
              ),
            ),
          ],
        );
      },
    );
  }

  void _checkAchievements(int count) {
    if (count == 108 || count == 1000 || count == 10000 || count == 36000) {
      _showAchievementDialog(count);
    }
  }

  void _showAchievementDialog(int count) {
    String message = '';
    if (count == 108) {
      message =
          "Khởi đầu vững chắc! Bạn đã hoàn thành 108 biến. 'Một niệm thanh tịnh, một niệm Phật.' - Hòa Thượng Tuyên Hóa";
    } else if (count == 1000) {
      message =
          "Thật tinh tấn! 1,000 biến là cột mốc lớn. Chư Thiên Hộ Pháp luôn bảo vệ người có lòng thành. - Hòa Thượng Phổ Quang";
    } else if (count == 10000) {
      message =
          "Công đức vô lượng! Nghiệp chướng nhiều đời đang dần tiêu trừ. Hãy hướng tới mục tiêu cuối cùng! - Hòa Thượng Tuyên Hóa";
    } else if (count == 36000) {
      message =
          "Viên mãn! Bạn đã đạt 36,000 biến. Hạt giống bồ đề đã bám rễ sâu. Hãy tiếp tục tu hành không thoái chuyển. - Hòa Thượng Tuyên Hóa";
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppPalette.glassPanel,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: const BorderSide(color: Color(0xFFD4AF37), width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.filter_vintage,
                  color: Color(0xFFD4AF37),
                  size: 60,
                ),
                const SizedBox(height: 16),
                Text(
                  'Cột Mốc $count Biến!',
                  style: const TextStyle(
                    color: Color(0xFFD4AF37),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  message,
                  style: const TextStyle(
                    color: Color(0xFFFDF5E6),
                    fontSize: 16,
                    height: 1.5,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4AF37),
                    foregroundColor: const Color(0xFF1B2D38),
                  ),
                  child: const Text(
                    'Tiếp tục Tinh Tấn',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPhone = MediaQuery.sizeOf(context).width < 600;
    return ScrollAwayPage(
      title: 'Trì Chú & Đếm Biến',
      body: SingleChildScrollView(
        key: const Key('mantra-page-scroll'),
        padding: EdgeInsets.fromLTRB(
          isPhone ? 4 : 20,
          isPhone ? 8 : 20,
          isPhone ? 4 : 20,
          isPhone ? 20 : (kIsWeb ? 110 : 20),
        ),
        child: Column(
          children: [
            // Mantra text
            Card(
              margin: EdgeInsets.zero,
              color: AppPalette.glassPanel,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
                side: const BorderSide(color: Color(0x33D4AF37), width: 1),
              ),
              child: Padding(
                padding: EdgeInsets.all(isPhone ? 6 : 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      key: const Key('mantra-reading-viewport'),
                      height: isPhone
                          ? (MediaQuery.sizeOf(context).height - 155)
                                .clamp(500.0, 720.0)
                                .toDouble()
                          : (MediaQuery.sizeOf(context).height - 170)
                                .clamp(440.0, 700.0)
                                .toDouble(),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0x661A0D08),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0x1FD4AF37)),
                      ),
                      padding: EdgeInsets.all(isPhone ? 8 : 20),
                      child: SingleChildScrollView(
                        key: const Key('mantra-reading-scroll'),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                _mantraTab(
                                  index: 0,
                                  label: 'Chú Lăng Nghiêm\ntiếng Việt',
                                  isPhone: isPhone,
                                ),
                                const SizedBox(width: 8),
                                _mantraTab(
                                  index: 1,
                                  label: 'Chú Lăng Nghiêm\ntiếng Phạn',
                                  isPhone: isPhone,
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            if (_selectedMantraTab == 0) ...[
                              const Row(
                                key: Key('mantra-reading-heading'),
                                children: [
                                  Icon(
                                    Icons.auto_stories_rounded,
                                    color: Color(0xFFD4AF37),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      'Văn Chú Lăng Nghiêm',
                                      style: TextStyle(
                                        color: Color(0xFFF4D35E),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              ...getMantraWidgets(),
                            ] else ...[
                              _sanskritTextCard(
                                title: 'Chú Lăng Nghiêm Tiếng Phạn',
                                content: surangamaSanskrit,
                              ),
                              const SizedBox(height: 18),
                              _sanskritTextCard(
                                title: 'CHÚ LĂNG NGHIÊM\n(Phiên Âm Tiếng Phạn)',
                                content: surangamaSanskritPhonetic,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Counter Section
            Card(
              color: AppPalette.glassPanel,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
                side: const BorderSide(color: Color(0x33D4AF37), width: 1),
              ),
              child: Padding(
                padding: EdgeInsets.all(isPhone ? 14 : 30),
                child: ValueListenableBuilder<int>(
                  valueListenable: widget.recitationCount,
                  builder: (context, count, child) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Decrement button
                            Container(
                              margin: EdgeInsets.only(right: isPhone ? 8 : 20),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppPalette.glassPanel,
                                border: Border.all(
                                  color: const Color(0x4DD4AF37),
                                ),
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.remove,
                                  color: Color(0xFFF4E9DC),
                                ),
                                onPressed: _decrementCount,
                                tooltip: 'Giảm 1 biến',
                              ),
                            ),

                            // Main Increment Button
                            GestureDetector(
                              onTap: _incrementCount,
                              child: Container(
                                width: isPhone ? 104 : 130,
                                height: isPhone ? 104 : 130,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFFD4AF37),
                                    width: 4,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x33D4AF37),
                                      blurRadius: 20,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      '+1',
                                      style: TextStyle(
                                        color: Color(0xFFD4AF37),
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '$count',
                                      style: const TextStyle(
                                        color: Color(0xFFD4AF37),
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Edit button
                            Container(
                              margin: EdgeInsets.only(left: isPhone ? 8 : 20),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppPalette.glassPanel,
                                border: Border.all(
                                  color: const Color(0x4DD4AF37),
                                ),
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Color(0xFFF4E9DC),
                                ),
                                onPressed: () => _showEditCountDialog(context),
                                tooltip: 'Chỉnh sửa chính xác',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        const Text(
                          'Lần Trì Tụng',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Milestone Bar
                        Container(
                          height: 8,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: (count / _goal).clamp(0.0, 1.0),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFD4AF37),
                                    Color(0xFFF28C28),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '0',
                              style: TextStyle(
                                color: AppPalette.secondaryText,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                shadows: AppPalette.readableTextShadow,
                              ),
                            ),
                            Text(
                              'Mục tiêu: $_goal',
                              style: const TextStyle(
                                color: AppPalette.secondaryText,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                shadows: AppPalette.readableTextShadow,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
