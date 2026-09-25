import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme/app_palette.dart';
import '../widgets/scroll_away_page.dart';

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
    return ScrollAwayPage(
      title: 'Lăng Nghiêm Tâm Cảnh',
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
              alignment: Alignment.centerLeft,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 480),
                width: isPhone ? double.infinity : 460,
                child: Padding(
                  padding: EdgeInsets.all(isPhone ? 22 : 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'THỜI KHÓA HÔM NAY',
                        style: TextStyle(
                          color: Color(0xFF765018),
                          fontSize: 12,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w700,
                          shadows: [
                            Shadow(color: Color(0xCCFFFFFF), blurRadius: 8),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'Trở về\nvới tâm an',
                        style: TextStyle(
                          color: Color(0xFF183442),
                          fontSize: 34,
                          height: 1.15,
                          fontWeight: FontWeight.w800,
                          shadows: [
                            Shadow(color: Color(0xDDFFFFFF), blurRadius: 12),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Dành một khoảng lặng\nđể trì tụng Chú Lăng Nghiêm.',
                        style: TextStyle(
                          color: Color(0xFF243D49),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 1.5,
                          shadows: [
                            Shadow(color: Color(0xDDFFFFFF), blurRadius: 8),
                          ],
                        ),
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

            // Tâm nguyện của ứng dụng
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: const BorderSide(color: Color(0x1AD4AF37), width: 1),
              ),
              child: Padding(
                padding: EdgeInsets.all(isPhone ? 18 : 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.spa_outlined,
                          color: Color(0xFFD4AF37),
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'TÂM NGUYỆN',
                          style: TextStyle(
                            color: Color(0xFFD4AF37),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      '''Ứng dụng này được tạo nên từ một tâm nguyện nhỏ, mong kết duyên cùng những người hữu duyên với Chú Lăng Nghiêm, cùng nhau tinh tấn hành trì và hướng đến viên mãn 36.000 biến Chú.

Nguyện nương nơi những lời khai thị quý báu của Hòa Thượng Tuyên Hóa và Hòa Thượng Phổ Quang, để đạo hữu có thêm niềm tin, nghị lực và sự nhắc nhở trên con đường tu học.

Mong rằng từng biến Chú được trì tụng không chỉ là một con số được ghi nhận, mà còn là một lần quay về với chánh niệm, nuôi lớn tâm Bồ Đề, gìn giữ chánh Pháp và chuyển hóa chính mình.

Nguyện cho những ai hữu duyên gặp được ứng dụng này đều bền lòng hành trì, tinh tấn tu học, tăng trưởng Bồ Đề tâm, cho đến ngày viên thành Phật Đạo.''',
                      style: TextStyle(
                        color: AppPalette.primaryText,
                        fontSize: isPhone ? 14.5 : 15.5,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        height: 1.6,
                        shadows: AppPalette.readableTextShadow,
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
                                color: Color(0xFFF4E9DC),
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
                                backgroundColor: const Color(0xD9364A52),
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
                                    color: AppPalette.secondaryText,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    shadows: AppPalette.readableTextShadow,
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
                            color: AppPalette.secondaryText,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            shadows: AppPalette.readableTextShadow,
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
                  foregroundColor: const Color(0xFF1B2D38),
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
