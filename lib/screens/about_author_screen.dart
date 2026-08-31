import 'package:flutter/material.dart';

class AboutAuthorScreen extends StatelessWidget {
  const AboutAuthorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Về Tác Giả', style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1A0D08),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFFD4AF37)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: const Color(0x33D4AF37), height: 1.0),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Intro
            const Text(
              'Chào quý đạo hữu, ứng dụng này được phát nguyện xây dựng hoàn toàn miễn phí bởi Liên Hoa Hóa Sanh, với tâm nguyện trợ duyên cho mọi người đạt mốc 36.000 biến Chú Lăng Nghiêm, hướng tới mục tiêu giải thoát ngay trong đời sống hiện tại.',
              style: TextStyle(color: Color(0xFFFDF5E6), fontSize: 16, height: 1.6),
            ),
            const SizedBox(height: 20),
            const Text(
              'Bên cạnh việc tu tập, nếu quý đạo hữu đang làm kinh doanh, muốn lan tỏa những sản phẩm tốt đến cộng đồng nhưng gặp khó khăn vì chưa biết cách tự xây dựng kênh truyền thông, hoặc mong muốn tạo ra sản phẩm số dựa trên kiến thức sẵn có của bạn.',
              style: TextStyle(color: Color(0xFFFDF5E6), fontSize: 16, height: 1.6),
            ),
            const SizedBox(height: 20),
            const Text(
              'Có thể bạn sẽ quan tâm những giải pháp thực chiến giúp xây dựng dòng tiền bền vững bằng sự tử tế và thấu cảm dưới đây:',
              style: TextStyle(color: Color(0xFFFDF5E6), fontSize: 16, height: 1.6),
            ),
            const SizedBox(height: 30),

            // Item 1
            _buildProductCard(
              title: '1. Ebook "Xây Kênh Ra Tiền Trong 90 Ngày"',
              content: 'Nội dung: Nghệ thuật biến lượt xem thành dòng tiền bền vững.\n'
                  'Mức gieo duyên: 99.000đ (Giá gốc: 299.000đ - Áp dụng cho 100 người đầu tiên).',
            ),
            const SizedBox(height: 20),

            // Item 2
            _buildProductCard(
              title: '2. Bộ Template Kịch Bản Sát Thủ Bán Hàng (.docx)',
              content: 'Nội dung: Bản Word cầm tay chỉ việc, điền thông tin là sở hữu ngay kịch bản chốt sale thực chiến.\n'
                  'Ưu đãi đặc biệt: Tặng kèm miễn phí Sản phẩm 1 (Ebook Xây Kênh Ra Tiền).\n'
                  'Mức gieo duyên: 299.000đ (Giá gốc: 499.000đ - Áp dụng cho 100 người đầu tiên).',
            ),
            const SizedBox(height: 20),

            // Item 3
            _buildProductCard(
              title: '3. Chương trình Coach 1-on-1: "Tự Tạo App Di Động Bằng AI"',
              content: 'Nội dung: Đồng hành cầm tay chỉ việc giúp bạn tự thiết kế và sở hữu ứng dụng di động của riêng mình bằng AI mà không cần biết lập trình. Cam kết hỗ trợ đến khi hoàn thành app.\n\n'
                  'Ưu đãi tối thượng: Tặng trọn bộ Sản phẩm 1 + Sản phẩm 2 (Trị giá 798.000đ) cùng toàn bộ Quà tặng bổ trợ.\n'
                  'Học phí ưu đãi: 1.999.000đ (Giá gốc: 5.000.000đ - Giới hạn 50 người đăng ký đầu tiên để bảo đảm chất lượng đồng hành trực tiếp).',
            ),
            const SizedBox(height: 20),

            // Gifts
            Card(
              color: const Color(0xFF2D1A11),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: const BorderSide(color: Color(0xFFD4AF37), width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '🎁 Quà tặng bổ trợ đi kèm (Trị giá 5.000.000đ):',
                      style: TextStyle(color: Color(0xFFD4AF37), fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '• App trắc nghiệm tương tác "Sales Killer Quiz"\n'
                      '• App thẻ ghi nhớ phản xạ đọc vị khách hàng\n'
                      '• Tài liệu dạy con theo trí tuệ cổ nhân và ứng dụng khoa học hiện đại\n'
                      '• Ebook 30 món chay tốt cho sức khỏe.',
                      style: TextStyle(color: Color(0xFFD1BFAE), fontSize: 15, height: 1.6),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Guarantee
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.redAccent.withAlpha(26),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.redAccent.withAlpha(128)),
              ),
              child: const Text(
                'Cam kết hoàn tiền trong 30 ngày nếu bạn làm theo hướng dẫn mà không ra kết quả.',
                style: TextStyle(color: Colors.redAccent, fontSize: 15, fontWeight: FontWeight.bold, height: 1.5),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),

            // Link Button
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Link chưa được cập nhật.', style: TextStyle(color: Color(0xFF1A0D08))),
                      backgroundColor: Color(0xFFD4AF37),
                    ),
                  );
                },
                icon: const Icon(Icons.link, color: Color(0xFF1A0D08)),
                label: const Text('Xem Chi Tiết', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4AF37),
                  foregroundColor: const Color(0xFF1A0D08),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard({required String title, required String content}) {
    return Card(
      color: const Color(0xFF2D1A11),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(color: Color(0x33D4AF37), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: const TextStyle(color: Color(0xFFD1BFAE), fontSize: 15, height: 1.6),
            ),
          ],
        ),
      ),
    );
  }
}
