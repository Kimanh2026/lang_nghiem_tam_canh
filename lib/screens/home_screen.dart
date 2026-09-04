import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  final ValueNotifier<int> recitationCount;
  final VoidCallback? onStartChanting;

  const HomeScreen({
    super.key,
    required this.recitationCount,
    this.onStartChanting,
  });

  Widget _buildBadge(String label, int milestone, int currentCount) {
    bool unlocked = currentCount >= milestone;
    return Column(
      children: [
        Icon(
          Icons.verified,
          color: unlocked ? const Color(0xFFD4AF37) : Colors.white24,
          size: 40,
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            color: unlocked ? const Color(0xFFD4AF37) : Colors.white54,
            fontSize: 12,
            fontWeight: unlocked ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  void _showEditCountDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController(
      text: recitationCount.value.toString(),
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
                  recitationCount.value = newValue;
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

  @override
  Widget build(BuildContext context) {
    final isPhone = MediaQuery.sizeOf(context).width < 600;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Lăng Nghiêm Tâm Cảnh',
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
            Container(
              width: double.infinity,
              constraints: const BoxConstraints(minHeight: 240),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                image: const DecorationImage(
                  image: AssetImage('assets/images/lotus-dawn.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Color(0x33000000),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'THỜI KHÓA HÔM NAY',
                    style: TextStyle(
                      color: Color(0xFFFFDF9E),
                      fontSize: 12,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Trở về\nvới tâm an',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      height: 1.15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Dành một khoảng lặng\nđể trì tụng Chú Lăng Nghiêm.',
                    style: TextStyle(color: Color(0xFFFFF3DF), height: 1.5),
                  ),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: onStartChanting,
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Bắt đầu trì chú'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Khai thi Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: const BorderSide(color: Color(0x1AD4AF37), width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.format_quote,
                          color: Color(0xFFD4AF37),
                          size: 16,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'LỜI KHAI THỊ',
                          style: TextStyle(
                            color: Color(0xFFD4AF37),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '"Hai mươi chín câu Chú đầu tiên, một khi niệm ra thì sẽ xuất hiện một cảnh giới là: bốn mặt tám phương có rất nhiều hoa sen đỏ đến ủng hộ người trì Chú này, cho nên nói: Ngàn đóa sen đỏ hộ người trì."',
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '- Hoà thượng Tuyên Hoá -',
                        style: TextStyle(
                          color: Color(0xFFD4AF37),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Progress Tracker Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: const BorderSide(color: Color(0x1AD4AF37), width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ValueListenableBuilder<int>(
                  valueListenable: recitationCount,
                  builder: (context, count, child) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Text(
                                'Tiến độ Trì Chú',
                                style: TextStyle(
                                  color: Color(0xFFD4AF37),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Color(0xFFD1BFAE),
                                size: 18,
                              ),
                              onPressed: () => _showEditCountDialog(context),
                              tooltip: 'Chỉnh sửa số biến',
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 150,
                              height: 150,
                              child: CircularProgressIndicator(
                                value: (count / 36000).clamp(0.0, 1.0),
                                strokeWidth: 10,
                                backgroundColor: const Color(0xFF3D2A20),
                                color: const Color(0xFFD4AF37),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '$count',
                                  style: const TextStyle(
                                    color: Color(0xFFD4AF37),
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  '/ 36,000',
                                  style: TextStyle(
                                    color: Color(0xFFD1BFAE),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Badges Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildBadge('108', 108, count),
                            _buildBadge('1K', 1000, count),
                            _buildBadge('10K', 10000, count),
                            _buildBadge('36K', 36000, count),
                          ],
                        ),
                        const SizedBox(height: 20),

                        const Text(
                          'Bạn đang đi đúng hướng. Hãy tiếp tục tinh tấn!',
                          style: TextStyle(
                            color: Color(0xFFD1BFAE),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Action Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: onStartChanting,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4AF37),
                  foregroundColor: const Color(0xFF1A0D08),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Bắt đầu Trì Chú',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
