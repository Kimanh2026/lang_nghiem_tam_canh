import 'package:google_generative_ai/google_generative_ai.dart';

void main() async {
  final String apiKey = 'YOUR_API_KEY_HERE';
  try {
    final model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: apiKey,
    );
    final chat = model.startChat(history: []);
    final response = await chat.sendMessage(Content.text('ta tên gì?'));
    print('Success: ${response.text}');
  } catch (e) {
    print('Error caught: $e');
  }
}
