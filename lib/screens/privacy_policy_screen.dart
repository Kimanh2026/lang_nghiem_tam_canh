import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chính Sách Bảo Mật', style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: const Color(0xFF1A0D08),
        iconTheme: const IconThemeData(color: Color(0xFFD4AF37)),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: const Color(0x33D4AF37), height: 1.0),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: const Text(
          '''Chính Sách Bảo Mật (Privacy Policy)
Ngày hiệu lực: 09 Tháng 09, 2026

Chào mừng bạn đến với ứng dụng Lăng Nghiêm Tâm Cảnh, được phát triển và vận hành bởi Liên Hoa Hóa Sanh.

Bảo vệ thông tin cá nhân và quyền riêng tư của Quý Đạo Hữu là ưu tiên hàng đầu của tôi. Chính sách Bảo mật này giải thích cách tôi thu thập, sử dụng và bảo vệ thông tin của bạn khi bạn sử dụng Ứng dụng.

1. Thông tin tôi thu thập
Ứng dụng của tôi được thiết kế tối giản nhằm bảo vệ tối đa quyền riêng tư của người dùng. Tôi thu thập và xử lý các loại thông tin sau:
- Dữ liệu lưu trữ cục bộ (Mã PIN): Ứng dụng có thể yêu cầu bạn thiết lập Mã PIN để bảo mật quyền truy cập. Mã PIN này chỉ được lưu trữ cục bộ (local storage) trên thiết bị của bạn. Tôi KHÔNG gửi mã PIN này lên bất kỳ máy chủ nào và hoàn toàn không có khả năng biết được mã PIN của bạn.
- Nội dung Trò chuyện AI (Chatbot Tiểu Tịnh): Khi bạn đặt câu hỏi hoặc trò chuyện với Trợ lý AI (Tiểu Tịnh), nội dung đoạn chat của bạn sẽ được thu thập và gửi tới dịch vụ AI của bên thứ ba để xử lý và tạo ra câu trả lời.

2. Dịch vụ của Bên Thứ Ba
Để cung cấp tính năng Trợ lý AI thông minh, tôi sử dụng dịch vụ Google Generative AI của Google.
- Nội dung văn bản bạn nhập vào khung chat sẽ được gửi trực tiếp và an toàn đến máy chủ của Google để phân tích và phản hồi.
- Việc Google sử dụng và bảo vệ dữ liệu này tuân theo Chính sách bảo mật của Google. Tôi không lưu trữ hoặc chia sẻ lịch sử trò chuyện của bạn cho bất kỳ mục đích tiếp thị hoặc cho bên thứ ba nào khác ngoài Google để phục vụ tính năng AI.

3. Quyền của người dùng
Do Ứng dụng không yêu cầu tạo tài khoản (không đăng nhập, không thu thập email hay số điện thoại) và phần lớn dữ liệu được lưu trên máy của bạn, bạn có toàn quyền kiểm soát dữ liệu của mình:
- Xóa dữ liệu: Bạn có thể xóa toàn bộ lịch sử chat và mã PIN bất kỳ lúc nào bằng cách xóa bộ nhớ cache/dữ liệu của ứng dụng trong phần cài đặt trình duyệt hoặc cài đặt điện thoại, hoặc gỡ cài đặt Ứng dụng.
- Không theo dõi: Chúng tôi không sử dụng cookies theo dõi (tracking cookies) hay bất kỳ phần mềm phân tích hành vi người dùng nào.

4. Bảo mật thông tin
Tôi cam kết bảo vệ thông tin của bạn. Các kết nối tới Trợ lý AI đều được mã hóa bằng giao thức HTTPS an toàn. Tuy nhiên, vì không có phương thức truyền tải dữ liệu trên Internet nào là an toàn 100%, chúng tôi không thể bảo đảm an ninh tuyệt đối cho dữ liệu, nhưng sẽ nỗ lực hết sức để áp dụng các tiêu chuẩn bảo mật cao nhất hiện có.

5. Thay đổi Chính sách Bảo mật
Tôi có thể cập nhật Chính sách Bảo mật này theo thời gian. Mọi thay đổi sẽ được thông báo thông qua Ứng dụng hoặc bằng cách cập nhật "Ngày hiệu lực" ở đầu trang này. Việc bạn tiếp tục sử dụng Ứng dụng sau khi có thay đổi đồng nghĩa với việc bạn chấp nhận Chính sách Bảo mật mới.

6. Liên hệ với tôi
Nếu bạn có bất kỳ thắc mắc hay góp ý nào về Chính sách Bảo mật này hoặc cách thức hoạt động của Ứng dụng, xin vui lòng liên hệ với tôi qua:
Tên nhà phát triển: Liên Hoa Hóa Sanh
Email: nkimanh932@gmail.com

A Mi Đà Phật! Chúc Quý Đạo Hữu luôn tinh tấn và an lạc.''',
          style: TextStyle(fontSize: 14, height: 1.6, color: Color(0xFFFDF5E6)),
        ),
      ),
    );
  }
}
