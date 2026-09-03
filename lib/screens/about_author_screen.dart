import 'package:flutter/material.dart';

class AboutAuthorScreen extends StatelessWidget {
  const AboutAuthorScreen({super.key});

  static const _gold = Color(0xFFD4AF37);
  static const _cream = Color(0xFFFDF5E6);
  static const _muted = Color(0xFFD1BFAE);
  static const _card = Color(0xFF2D1A11);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Người Xây Dựng Ứng Dụng',
          style: TextStyle(color: _gold, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1A0D08),
        elevation: 0,
        iconTheme: const IconThemeData(color: _gold),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: const Color(0x33D4AF37), height: 1),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildAuthorIntro(),
                const SizedBox(height: 24),
                _buildServiceCard(),
                const SizedBox(height: 24),
                _buildContactCard(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAuthorIntro() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Liên Hoa Hóa Sanh',
          style: TextStyle(
            color: _gold,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Chào quý đạo hữu, mình xây dựng Lăng Nghiêm Tâm Cảnh bằng các công cụ AI với mong muốn tạo một ứng dụng đơn giản, dễ sử dụng và hoàn toàn miễn phí để hỗ trợ việc học và thực hành.',
          style: TextStyle(color: _cream, fontSize: 16, height: 1.6),
        ),
        SizedBox(height: 12),
        Text(
          'Mình không phải giảng sư hay người hướng dẫn Phật pháp. Nội dung trong ứng dụng mang tính hỗ trợ; quý đạo hữu nên đối chiếu thêm với kinh điển và các vị có chuyên môn.',
          style: TextStyle(color: _muted, fontSize: 15, height: 1.6),
        ),
      ],
    );
  }

  Widget _buildServiceCard() {
    return Card(
      color: _card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0x55D4AF37)),
      ),
      child: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bạn cũng muốn tự tạo một ứng dụng bằng AI?',
              style: TextStyle(
                color: _gold,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 14),
            Text(
              'Ứng dụng bạn đang sử dụng là một sản phẩm mình tự xây bằng AI mà không cần xuất thân là lập trình viên.',
              style: TextStyle(color: _cream, fontSize: 16, height: 1.6),
            ),
            SizedBox(height: 12),
            Text(
              'Nếu bạn có một ý tưởng, kiến thức hoặc công việc muốn đóng gói thành ứng dụng riêng, mình có chương trình đồng hành 1–1 giúp bạn:',
              style: TextStyle(color: _muted, fontSize: 15, height: 1.6),
            ),
            SizedBox(height: 10),
            Text(
              '• Làm rõ ý tưởng và những tính năng thật sự cần thiết.\n'
              '• Tạo phiên bản ứng dụng đầu tiên có thể sử dụng.\n'
              '• Biết cách tự chỉnh sửa và phát triển ứng dụng bằng AI.',
              style: TextStyle(color: _cream, fontSize: 15, height: 1.7),
            ),
            SizedBox(height: 16),
            Text(
              'Chi phí đồng hành: 1.999.000đ',
              style: TextStyle(
                color: _gold,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Mình chỉ nhận đồng hành sau khi xem ý tưởng và tin rằng có thể hỗ trợ bạn.',
              style: TextStyle(color: _muted, fontSize: 14, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _gold),
      ),
      child: Column(
        children: [
          const Text(
            'Nhắn Zalo để mình xem ý tưởng miễn phí',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _gold,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Quét mã QR và gửi tin nhắn:\n“Chào bạn, mình biết đến chương trình tạo app AI qua ứng dụng Lăng Nghiêm Tâm Cảnh. Ý tưởng app của mình là…”',
            textAlign: TextAlign.center,
            style: TextStyle(color: _cream, fontSize: 15, height: 1.5),
          ),
          const SizedBox(height: 18),
          Semantics(
            label: 'Mã QR Zalo của Liên Hoa Hóa Sanh',
            image: true,
            child: Container(
              width: 190,
              height: 190,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                'assets/images/zalo-qr.png',
                fit: BoxFit.contain,
                filterQuality: FilterQuality.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const SelectableText(
            'Email: nkimanh932@gmail.com',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _cream,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
