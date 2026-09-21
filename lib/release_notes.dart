import 'package:flutter/material.dart';

import 'theme/app_palette.dart';

class AppReleaseNotes {
  const AppReleaseNotes._();

  static const version = '1.5.5+22';
  static const displayVersion = '1.5.5';
  static const seenVersionKey = 'last_seen_release_notes_version';
  static const title = 'Khai thị dễ đọc hơn';
  static const changes = <String>[
    'Tách chín chủ đề khai thị của Hòa Thượng Tuyên Hóa thành từng bài riêng.',
    'Mỗi bài ngắn gọn hơn, dễ tìm và thuận tiện đọc trên điện thoại.',
    'Loại bỏ đoạn nội dung không còn cần thiết theo góp ý.',
  ];

  static bool shouldAnnounce(String? lastSeenVersion) =>
      lastSeenVersion != version;
}

Future<void> showCurrentReleaseNotes(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (dialogContext) => Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 460),
        padding: const EdgeInsets.fromLTRB(22, 22, 22, 18),
        decoration: BoxDecoration(
          color: AppPalette.glassPanel,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0x66D4AF37)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x66000000),
              blurRadius: 30,
              offset: Offset(0, 14),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    padding: const EdgeInsets.all(7),
                    decoration: const BoxDecoration(
                      color: Color(0x1FD4AF37),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/icons/nav-mantra.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ỨNG DỤNG ĐÃ ĐƯỢC CẬP NHẬT',
                          style: TextStyle(
                            color: Color(0xFFF4D35E),
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          AppReleaseNotes.title,
                          style: TextStyle(
                            color: Color(0xFFFDF5E6),
                            fontSize: 19,
                            height: 1.25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF1B2D38),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: const Color(0x33D4AF37)),
                ),
                child: const Text(
                  'Phiên bản ${AppReleaseNotes.displayVersion}',
                  style: TextStyle(
                    color: Color(0xFFD4AF37),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              for (final change in AppReleaseNotes.changes)
                Padding(
                  padding: const EdgeInsets.only(bottom: 13),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Icon(
                          Icons.auto_awesome,
                          size: 18,
                          color: Color(0xFFD4AF37),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          change,
                          style: const TextStyle(
                            color: Color(0xFFE8D9CC),
                            fontSize: 14,
                            height: 1.45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 4),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('Đã hiểu'),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFFD4AF37),
                    foregroundColor: const Color(0xFF1B2D38),
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
