import 'package:google_generative_ai/google_generative_ai.dart';

void main() async {
  final String apiKey = 'YOUR_API_KEY_HERE';
  try {
    final model = GenerativeModel(
      model: 'gemini-3.6-flash',
      apiKey: apiKey,
    );
    final response = await model.generateContent([Content.text('Hello')]);
    print('Success: ${response.text}');
  } catch (e) {
    print('Error caught: $e');
  }
}
