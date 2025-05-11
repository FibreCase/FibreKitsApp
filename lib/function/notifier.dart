import 'package:http/http.dart' as http;

class NtfyNotifier {
  static Future<bool> sendMessage({
    required String topic,
    required String title,
    required String message,
    String priority = "default",
    List<String> tags = const [],
    String baseUrl = 'https://ntfy.sh/',
  }) async {
    final url = Uri.parse('$baseUrl$topic');

    final headers = {
      'Title': title,
      'Priority': priority,
      'Tags': tags.join(','),
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: message,
      );

      if (response.statusCode == 200 || response.statusCode == 202) {
        print('发送成功: ${response.statusCode}, 内容: ${response.body}');
        return true;
      } else {
        print('发送失败: ${response.statusCode}, 内容: ${response.body}');
        return false;
      }
    } catch (e) {
      print('发送请求时发生错误: $e');
      return false;
    }
  }
}
