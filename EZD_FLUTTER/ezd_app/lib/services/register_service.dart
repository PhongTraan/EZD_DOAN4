import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterService {
  static const String apiUrl = 'http://172.16.1.30:8081/api/v1/auth/signup';
  // static const String apiUrl = 'http://localhost:8081/api/v1/auth/signup';
  // static const String apiUrl = 'http://192.168.1.48081/api/v1/auth/signup';
  Future<String?> register(
    String username,
    String email,
    String password,
    String address,
    String phone,
    DateTime? birthday,
  ) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      'username': username,
      'email': email,
      'password': password,
      'address': address,
      'phone': phone,
      "birthday": birthday.toString(),
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return 'success'; // Hoặc bất kỳ chuỗi nào bạn muốn trả về khi đăng ký thành công
      } else {
        // Đăng ký thất bại
        print('Lỗi đăng ký: ${response.statusCode}');
        return null; // Hoặc bất kỳ giá trị nào bạn muốn trả về khi đăng ký thất bại
      }
    } catch (e) {
      // Xử lý lỗi từ API
      print('Lỗi không xác định: $e');
      return null; // Hoặc bất kỳ giá trị nào bạn muốn trả về khi có lỗi
    }
  }
}
