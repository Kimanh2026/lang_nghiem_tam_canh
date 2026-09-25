import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:math' as math;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme/app_palette.dart';
import '../widgets/scroll_away_page.dart';

class SpinningLotusLoading extends StatefulWidget {
  final double size;
  const SpinningLotusLoading({super.key, this.size = 40.0});

  @override
  State<SpinningLotusLoading> createState() => _SpinningLotusLoadingState();
}

class _SpinningLotusLoadingState extends State<SpinningLotusLoading>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 4),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * math.pi,
          child: child,
        );
      },
      child: Icon(
        Icons.filter_vintage,
        color: const Color(0xFFD4AF37),
        size: widget.size,
      ),
    );
  }
}

class AiCoachScreen extends StatefulWidget {
  final ValueNotifier<String> userName;
  final ValueNotifier<int> clearChatTrigger;

  const AiCoachScreen({
    super.key,
    required this.userName,
    required this.clearChatTrigger,
  });

  @override
  State<AiCoachScreen> createState() => _AiCoachScreenState();
}

class _AiCoachScreenState extends State<AiCoachScreen> {
  static final Uri _chatProxyUri = Uri.parse(
    'https://lang-nghiem-tieu-tinh.nkimanh932.workers.dev/',
  );

  bool _isLoading = false;

  final TextEditingController _chatController = TextEditingController();
  final ScrollController _chatScrollController = ScrollController();

  final List<Map<String, String>> _chatMessages = [];

  @override
  void initState() {
    super.initState();
    _loadChatHistory();

    widget.clearChatTrigger.addListener(_onClearChatTriggered);
  }

  @override
  void dispose() {
    widget.clearChatTrigger.removeListener(_onClearChatTriggered);
    _chatController.dispose();
    _chatScrollController.dispose();
    super.dispose();
  }

  void _scrollToNewestMessage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_chatScrollController.hasClients) return;
      _chatScrollController.animateTo(
        _chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
      );
    });
  }

  List<Map<String, String>> _buildProxyMessages() {
    final messages = <Map<String, String>>[];
    for (final message in _chatMessages) {
      final role = message['role'] == 'user' ? 'user' : 'model';
      final text = (message['text'] ?? '').trim();
      if (text.isEmpty || (messages.isEmpty && role == 'model')) continue;

      if (messages.isNotEmpty && messages.last['role'] == role) {
        messages.last['text'] = '${messages.last['text']}\n$text';
      } else {
        messages.add({'role': role, 'text': text});
      }
    }
    return messages.length <= 30
        ? messages
        : messages.sublist(messages.length - 30);
  }

  void _onClearChatTriggered() {
    setState(() {
      _chatMessages.clear();
      _addInitialGreeting();
      _saveChatHistory();
    });
    _scrollToNewestMessage();
  }

  void _addInitialGreeting() {
    final String currentName = widget.userName.value.trim();
    final String greeting = currentName.isNotEmpty
        ? 'A Mi Đà Phật! Con là Tiểu Tịnh, chào Đạo Hữu $currentName. Mục tiêu đạt được 36.000 biến Chú Lăng Nghiêm. Đạo Hữu có thắc mắc gì về việc trì tụng chú Lăng Nghiêm không?'
        : 'A Mi Đà Phật! Con là Tiểu Tịnh, được đào tạo để trợ giúp chư vị Đạo Hữu tinh tấn trên con đường giải thoát. Mục tiêu đạt được 36.000 biến Chú Lăng Nghiêm. Đạo Hữu có thắc mắc gì về việc trì tụng chú Lăng Nghiêm không?';
    _chatMessages.add({'role': 'ai', 'text': greeting});
  }

  Future<void> _loadChatHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? historyJson = prefs.getString('chat_history');
    setState(() {
      if (historyJson != null && historyJson.isNotEmpty) {
        try {
          final List<dynamic> decoded = jsonDecode(historyJson);
          for (var item in decoded) {
            if (item is Map) {
              _chatMessages.add({
                'role': item['role']?.toString() ?? 'user',
                'text': item['text']?.toString() ?? '',
              });
            }
          }
        } catch (e) {
          print('Error decoding history: $e');
          _addInitialGreeting();
        }
      } else {
        _addInitialGreeting();
      }
    });
    _scrollToNewestMessage();
  }

  Future<void> _saveChatHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('chat_history', jsonEncode(_chatMessages));
  }

  Future<void> _sendChatMessage() async {
    final text = _chatController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _chatMessages.add({'role': 'user', 'text': text});
      _isLoading = true;
      _saveChatHistory();
    });
    _chatController.clear();
    _scrollToNewestMessage();

    try {
      final response = await _sendMessageWithRetry();
      if (!mounted) return;
      setState(() {
        _chatMessages.add({'role': 'ai', 'text': response.replaceAll('*', '')});
        _saveChatHistory();
      });
      _scrollToNewestMessage();
    } catch (e) {
      if (!mounted) return;
      debugPrint('AI request failed after retry: ${e.runtimeType}');
      setState(() {
        _chatMessages.add({'role': 'ai', 'text': _friendlyChatError(e)});
        _saveChatHistory();
      });
      _scrollToNewestMessage();
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _scrollToNewestMessage();
      }
    }
  }

  Future<String> _sendMessageWithRetry() async {
    Object? firstError;
    for (var attempt = 0; attempt < 2; attempt++) {
      try {
        final response = await http
            .post(
              _chatProxyUri,
              headers: const {
                'Content-Type': 'application/json; charset=utf-8',
              },
              body: jsonEncode({
                'userName': widget.userName.value.trim(),
                'messages': _buildProxyMessages(),
              }),
            )
            .timeout(const Duration(seconds: 40));
        if (response.statusCode != 200) {
          throw _ChatProxyException(response.statusCode);
        }
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        final answer = data is Map ? data['text']?.toString().trim() : null;
        if (answer == null || answer.isEmpty) {
          throw const _ChatProxyException(502);
        }
        return answer;
      } catch (error) {
        firstError ??= error;
        if (attempt == 1 || !_isRetryableChatError(error)) rethrow;
        await Future<void>.delayed(const Duration(milliseconds: 700));
      }
    }
    throw firstError!;
  }

  bool _isRetryableChatError(Object error) {
    final message = error.toString().toLowerCase();
    return error is TimeoutException ||
        error is http.ClientException ||
        (error is _ChatProxyException && error.statusCode >= 429) ||
        message.contains('429') ||
        message.contains('resource_exhausted') ||
        message.contains('temporar') ||
        message.contains('network') ||
        message.contains('connection') ||
        message.contains('socket') ||
        message.contains('timeout') ||
        message.contains('unavailable') ||
        message.contains('500') ||
        message.contains('502') ||
        message.contains('503') ||
        message.contains('504');
  }

  String _friendlyChatError(Object error) {
    final message = error.toString().toLowerCase();
    if ((error is _ChatProxyException && error.statusCode == 429) ||
        message.contains('429') ||
        message.contains('resource_exhausted')) {
      return 'Tiểu Tịnh đang có nhiều người hỏi cùng lúc. Đạo Hữu vui lòng chờ một lát rồi gửi lại câu hỏi.';
    }
    if (error is TimeoutException ||
        message.contains('network') ||
        message.contains('connection') ||
        message.contains('socket') ||
        message.contains('timeout')) {
      return 'Kết nối đang chậm nên Tiểu Tịnh chưa thể trả lời. Đạo Hữu vui lòng kiểm tra mạng và gửi lại câu hỏi.';
    }
    return 'Tiểu Tịnh tạm thời chưa thể trả lời. Đạo Hữu vui lòng thử lại sau ít phút.';
  }

  @override
  Widget build(BuildContext context) {
    final isPhone = MediaQuery.sizeOf(context).width < 600;
    return ScrollAwayPage(
      title: 'Tiểu Tịnh',
      actions: [
        IconButton(
          icon: const Icon(Icons.delete_outline, color: Color(0xFFD4AF37)),
          tooltip: 'Xóa lịch sử chat',
          onPressed: _onClearChatTriggered,
        ),
        const SizedBox(width: 8),
      ],
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          isPhone ? 10 : 20,
          isPhone ? 10 : 20,
          isPhone ? 10 : 20,
          isPhone ? 12 : (kIsWeb ? 100 : 20),
        ),
        child: Column(
          children: [
            // Main Content Area
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: const BorderSide(color: Color(0x1AD4AF37), width: 1),
                ),
                child: Padding(
                  padding: EdgeInsets.all(isPhone ? 10 : 15),
                  child: _buildChatMode(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatMode() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            key: const Key('chat-message-list'),
            controller: _chatScrollController,
            itemCount: _chatMessages.length,
            itemBuilder: (context, index) {
              final msg = _chatMessages[index];
              final isAi = msg['role'] == 'ai';
              return _buildChatBubble(msg['text']!, isAi);
            },
          ),
        ),
        if (_isLoading)
          Semantics(
            liveRegion: true,
            label: 'Tiểu Tịnh đang suy ngẫm',
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpinningLotusLoading(size: 26),
                  SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      'Tiểu Tịnh đang suy ngẫm…',
                      key: Key('chat-loading-label'),
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _chatController,
                decoration: InputDecoration(
                  hintText: 'Nhập câu hỏi...',
                  hintStyle: const TextStyle(
                    color: AppPalette.secondaryText,
                    fontWeight: FontWeight.w600,
                    shadows: AppPalette.readableTextShadow,
                  ),
                  filled: true,
                  fillColor: AppPalette.glassPanel,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Color(0x4DD4AF37)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Color(0xFFD4AF37)),
                  ),
                ),
                onSubmitted: (_) => _sendChatMessage(),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFD4AF37), Color(0xFFF28C28)],
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: IconButton(
                icon: const Icon(Icons.send, color: Color(0xFF1B2D38)),
                onPressed: _isLoading ? null : _sendChatMessage,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChatBubble(String text, bool isAi) {
    final isPhone = MediaQuery.sizeOf(context).width < 600;
    return Align(
      alignment: isAi ? Alignment.centerLeft : Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isAi)
            const Padding(
              padding: EdgeInsets.only(right: 8.0, top: 2.0),
              child: CircleAvatar(
                radius: 14,
                backgroundImage: AssetImage('assets/images/tieutinh.jpg'),
                backgroundColor: Color(0xFFD4AF37),
              ),
            ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              margin: EdgeInsets.only(
                bottom: 15,
                left: isAi ? 0 : (isPhone ? 8 : 40),
                right: isAi ? (isPhone ? 8 : 40) : 0,
              ),
              decoration: BoxDecoration(
                color: isAi ? AppPalette.glassPanel : null,
                gradient: isAi
                    ? null
                    : const LinearGradient(
                        colors: [Color(0x33D4AF37), Color(0x33F28C28)],
                      ),
                border: isAi
                    ? Border.all(color: const Color(0x1AD4AF37))
                    : null,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(8),
                  topRight: const Radius.circular(8),
                  bottomLeft: Radius.circular(isAi ? 0 : 8),
                  bottomRight: Radius.circular(isAi ? 8 : 0),
                ),
              ),
              child: Text(
                text,
                style: const TextStyle(fontSize: 14, height: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatProxyException implements Exception {
  final int statusCode;
  const _ChatProxyException(this.statusCode);

  @override
  String toString() => 'Chat proxy returned HTTP $statusCode';
}
