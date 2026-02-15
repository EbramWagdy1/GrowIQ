import 'dart:convert';
import 'package:http/http.dart' as http;

class GroqService {
  static const String _url =
      "https://my-backend-three-orcin.vercel.app/chat";

  Future<String> sendMessage({
    required List<Map<String, String>> messages,
    required String apiKey,
  }) async {
    final response = await http.post(
      Uri.parse(_url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        "model": "llama-3.1-8b-instant",
        "messages": messages,
        "temperature": 0.7,
        "max_tokens": 1024
      }),
    );

    if (response.statusCode != 200) {
      throw Exception("Server Error ${response.statusCode}");
    }

    final data = jsonDecode(utf8.decode(response.bodyBytes));
    return data['choices'][0]['message']['content'] ?? "";
  }
}
