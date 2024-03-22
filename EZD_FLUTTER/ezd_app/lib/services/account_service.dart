import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  // final String baseUrl;

  // UserService(this.baseUrl);

  Future<Map<String, dynamic>?> getUserById(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:8081/api/v1/auth/$userId?role=USER'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        // Xử lý lỗi khi kết nối với API
        print('Failed to load user info: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Xử lý lỗi mạng
      print('Network error: $e');
      return null;
    }
  }
}
