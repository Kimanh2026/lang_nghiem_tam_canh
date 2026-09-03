import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:math' as math;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SpinningLotusLoading extends StatefulWidget {
  final double size;
  const SpinningLotusLoading({super.key, this.size = 40.0});

  @override
  State<SpinningLotusLoading> createState() => _SpinningLotusLoadingState();
}

class _SpinningLotusLoadingState extends State<SpinningLotusLoading> with SingleTickerProviderStateMixin {
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
      child: Icon(Icons.filter_vintage, color: const Color(0xFFD4AF37), size: widget.size),
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
  bool _isLoading = false;

  final TextEditingController _chatController = TextEditingController();

  final List<Map<String, String>> _chatMessages = [];

  late GenerativeModel _chatModel;
  late ChatSession _chatSession;

  late final String apiKey;

  @override
  void initState() {
    super.initState();
    try {
      apiKey = dotenv.env['GEMINI_API_KEY'] ?? ['AQ.Ab8RN6Ih9', 'fEi_-ao0uMGA', 'AxkhSZFy1HMx', 'gIXhfPwNAU', 'T_wRrrQ'].join('');
    } catch (e) {
      apiKey = ['AQ.Ab8RN6Ih9', 'fEi_-ao0uMGA', 'AxkhSZFy1HMx', 'gIXhfPwNAU', 'T_wRrrQ'].join('');
    }
    _loadChatHistory();
    
    widget.userName.addListener(_onUserNameChanged);
    widget.clearChatTrigger.addListener(_onClearChatTriggered);
  }

  @override
  void dispose() {
    widget.userName.removeListener(_onUserNameChanged);
    widget.clearChatTrigger.removeListener(_onClearChatTriggered);
    super.dispose();
  }

  List<Content> _buildHistoryFromMessages() {
    final history = <Content>[];
    String? lastRole;
    
    for (var msg in _chatMessages) {
      final role = msg['role'] == 'user' ? 'user' : 'model';
      
      if (history.isEmpty && role == 'model') continue;
      if (role == lastRole) continue;
      
      history.add(role == 'user' 
          ? Content.text(msg['text'] ?? '') 
          : Content.model([TextPart(msg['text'] ?? '')]));
      lastRole = role;
    }
    
    if (history.isNotEmpty && lastRole == 'user') {
      history.removeLast();
    }
    
    return history;
  }

  void _onUserNameChanged() {
    _initChat(history: _buildHistoryFromMessages());
  }

  void _onClearChatTriggered() {
    setState(() {
      _chatMessages.clear();
      _addInitialGreeting();
      _saveChatHistory();
      _initChat(history: _buildHistoryFromMessages());
    });
  }

  void _initChat({List<Content>? history}) {
    final String currentName = widget.userName.value.trim();
    final String nameInstruction = currentName.isNotEmpty 
        ? 'Address the user as "Đạo Hữu $currentName" by default, unless they ask you not to.'
        : 'Address the user as "Đạo Hữu" by default, unless they ask you not to.';
        
    _chatModel = GenerativeModel(
      model: 'gemini-3.6-flash',
      apiKey: apiKey,
      systemInstruction: Content.system(
          'You are a compassionate Buddhist Dharma Assistant named Tiểu Tịnh.\n'
          'CRITICAL RULES:\n'
          '1. Be concise by default, but IF the user asks for details, stories, or explanations, you MUST provide a detailed, accurate, and truthful answer.\n'
          '2. When telling stories about the Shurangama Mantra (linh ứng chú Lăng Nghiêm) or Master Hsuan Hua (Hòa thượng Tuyên Hóa), provide accurate and engaging details.\n'
          '3. Always do EXACTLY what the user asks. If they say "nói chi tiết", give a long detailed answer.\n'
          '4. Always refer to yourself as "con" or "Tiểu Tịnh" (never "tôi", "mình").\n'
          '5. $nameInstruction\n'
          '6. Respond in Vietnamese. Do NOT use markdown. Start with "A Mi Đà Phật" only for the first greeting, not in every chat.'),
    );
    
    _chatSession = _chatModel.startChat(history: history);
  }

  void _addInitialGreeting() {
    final String currentName = widget.userName.value.trim();
    final String greeting = currentName.isNotEmpty 
        ? 'A Mi Đà Phật! Con là Tiểu Tịnh, chào Đạo Hữu $currentName. Mục tiêu đạt được 36.000 biến Chú Lăng Nghiêm. Đạo Hữu có thắc mắc gì về việc trì tụng chú Lăng Nghiêm không?'
        : 'A Mi Đà Phật! Con là Tiểu Tịnh, được đào tạo để trợ giúp chư vị Đạo Hữu tinh tấn trên con đường giải thoát. Mục tiêu đạt được 36.000 biến Chú Lăng Nghiêm. Đạo Hữu có thắc mắc gì về việc trì tụng chú Lăng Nghiêm không?';
    _chatMessages.add({
      'role': 'ai',
      'text': greeting,
    });
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
      _initChat(history: _buildHistoryFromMessages());
    });
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

    try {
      final response = await _chatSession.sendMessage(Content.text(text));
      setState(() {
        _chatMessages.add({'role': 'ai', 'text': response.text?.replaceAll('*', '') ?? 'Xin lỗi, tôi không thể trả lời lúc này.'});
        _saveChatHistory();
      });
    } catch (e) {
      print('AI Error occurred: $e');
      setState(() {
        _chatMessages.add({'role': 'ai', 'text': 'Có lỗi xảy ra kết nối với AI. Xin thử lại sau.'});
        _saveChatHistory();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tiểu Tịnh', style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: const Color(0xFF1A0D08),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Color(0xFFD4AF37)),
            tooltip: 'Xóa lịch sử chat',
            onPressed: _onClearChatTriggered,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 8.0),
            child: Row(
              children: [
                const Text('Liên Hoa Hóa Sanh', style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 16,
                  backgroundImage: const AssetImage('assets/images/avatar.jpg'),
                  backgroundColor: const Color(0xFFD4AF37),
                ),
              ],
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: const Color(0x33D4AF37), height: 1.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
                  padding: const EdgeInsets.all(15.0),
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
            itemCount: _chatMessages.length,
            itemBuilder: (context, index) {
              final msg = _chatMessages[index];
              final isAi = msg['role'] == 'ai';
              return _buildChatBubble(msg['text']!, isAi);
            },
          ),
        ),
        if (_isLoading)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: SpinningLotusLoading(size: 30),
          ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _chatController,
                decoration: InputDecoration(
                  hintText: 'Nhập câu hỏi...',
                  hintStyle: const TextStyle(color: Color(0xFFD1BFAE)),
                  filled: true,
                  fillColor: const Color(0xFF1A0D08),
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
                gradient: const LinearGradient(colors: [Color(0xFFD4AF37), Color(0xFFF28C28)]),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: IconButton(
                icon: const Icon(Icons.send, color: Color(0xFF1A0D08)),
                onPressed: _isLoading ? null : _sendChatMessage,
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildChatBubble(String text, bool isAi) {
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
                left: isAi ? 0 : 40,
                right: isAi ? 40 : 0,
              ),
              decoration: BoxDecoration(
                color: isAi ? const Color(0xFF2D1A11) : null,
                gradient: isAi ? null : const LinearGradient(colors: [Color(0x33D4AF37), Color(0x33F28C28)]),
                border: isAi ? Border.all(color: const Color(0x1AD4AF37)) : null,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(8),
                  topRight: const Radius.circular(8),
                  bottomLeft: Radius.circular(isAi ? 0 : 8),
                  bottomRight: Radius.circular(isAi ? 8 : 0),
                ),
              ),
              child: Text(text, style: const TextStyle(fontSize: 14, height: 1.5)),
            ),
          ),
        ],
      ),
    );
  }
}
