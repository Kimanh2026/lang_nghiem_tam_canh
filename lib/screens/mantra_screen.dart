import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/mantra_text.dart';

class MantraScreen extends StatefulWidget {
  final ValueNotifier<int> recitationCount;

  const MantraScreen({super.key, required this.recitationCount});

  @override
  State<MantraScreen> createState() => _MantraScreenState();
}

class _MantraScreenState extends State<MantraScreen> {
  final int _goal = 36000;

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
          backgroundColor: const Color(0xFF2D1A11),
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
              hintStyle: TextStyle(color: Colors.white54),
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
              child: const Text('Hủy', style: TextStyle(color: Colors.white54)),
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
          backgroundColor: const Color(0xFF1A0D08),
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
                    foregroundColor: const Color(0xFF1A0D08),
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

  Widget _buildPracticeImageCard({
    required String asset,
    required String eyebrow,
    required String title,
    required String subtitle,
    required double width,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: SizedBox(
        width: width,
        height: 210,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              asset,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              semanticLabel: title,
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x08000000), Color(0xF21A0D08)],
                  stops: [0.35, 1],
                ),
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    eyebrow,
                    style: const TextStyle(
                      color: Color(0xFFF4D35E),
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFFFDF5E6),
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFFD1BFAE),
                      fontSize: 13,
                      height: 1.35,
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

  Widget _buildPracticeGallery(bool isPhone) {
    if (isPhone) {
      return SizedBox(
        key: const Key('practice-gallery'),
        height: 92,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 2,
          separatorBuilder: (_, _) => const SizedBox(width: 12),
          itemBuilder: (_, index) {
            final isMantra = index == 0;
            return ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                width: 158,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      isMantra
                          ? 'assets/images/lang-nghiem-mandala.jpeg'
                          : 'assets/images/ngu-phuong-phat.jpg',
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0x00000000), Color(0xE61A0D08)],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      right: 10,
                      bottom: 8,
                      child: Text(
                        isMantra ? 'Chú Lăng Nghiêm' : 'Ngũ Phương Phật',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFFFDF5E6),
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }

    return Row(
      children: [
        Expanded(
          child: _buildPracticeImageCard(
            asset: 'assets/images/lang-nghiem-mandala.jpeg',
            eyebrow: 'TÂM CHÚ HỘ TRÌ',
            title: 'Chú Lăng Nghiêm',
            subtitle: 'Đọc chậm, rõ tiếng và giữ tâm chuyên nhất.',
            width: double.infinity,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildPracticeImageCard(
            asset: 'assets/images/ngu-phuong-phat.jpg',
            eyebrow: 'NGŨ PHƯƠNG PHẬT',
            title: 'Năm Đại Tâm Chú',
            subtitle: 'Năm câu tâm chú gắn với Ngũ phương Phật.',
            width: double.infinity,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPhone = MediaQuery.sizeOf(context).width < 600;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Trì Chú & Đếm Biến',
          style: TextStyle(
            color: Color(0xFFD4AF37),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: const Color(0xFF1A0D08),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                if (!isPhone)
                  const Text(
                    'Liên Hoa Hóa Sanh',
                    style: TextStyle(
                      color: Color(0xFFD4AF37),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                if (!isPhone) const SizedBox(width: 8),
                const CircleAvatar(
                  radius: 16,
                  backgroundImage: AssetImage('assets/images/avatar.jpg'),
                  backgroundColor: Color(0xFFD4AF37),
                ),
              ],
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: const Color(0x33D4AF37), height: 1.0),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          isPhone ? 12 : 20,
          isPhone ? 12 : 20,
          isPhone ? 12 : 20,
          isPhone ? 20 : (kIsWeb ? 110 : 20),
        ),
        child: Column(
          children: [
            if (!isPhone) _buildPracticeGallery(false),
            if (!isPhone) const SizedBox(height: 20),

            // Mantra text
            Card(
              color: const Color(0xFF2A160F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
                side: const BorderSide(color: Color(0x33D4AF37), width: 1),
              ),
              child: Padding(
                padding: EdgeInsets.all(isPhone ? 12 : 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
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
                    Container(
                      key: const Key('mantra-reading-viewport'),
                      height: isPhone
                          ? (MediaQuery.sizeOf(context).height * 0.62)
                                .clamp(360.0, 560.0)
                                .toDouble()
                          : 350,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0x661A0D08),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0x1FD4AF37)),
                      ),
                      padding: EdgeInsets.all(isPhone ? 12 : 20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: getMantraWidgets(),
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
              color: const Color(0xFF2A160F),
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
                                color: const Color(0xFF2D1A11),
                                border: Border.all(
                                  color: const Color(0x4DD4AF37),
                                ),
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.remove,
                                  color: Color(0xFFD1BFAE),
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
                                color: const Color(0xFF2D1A11),
                                border: Border.all(
                                  color: const Color(0x4DD4AF37),
                                ),
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Color(0xFFD1BFAE),
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
                                color: Color(0xFFD1BFAE),
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Mục tiêu: $_goal',
                              style: const TextStyle(
                                color: Color(0xFFD1BFAE),
                                fontSize: 12,
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
            if (isPhone) const SizedBox(height: 16),
            if (isPhone) _buildPracticeGallery(true),
          ],
        ),
      ),
    );
  }
}
