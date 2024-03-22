import 'dart:convert';
import 'package:http/http.dart' as http;

class ForgotService {
  static const String baseUrl =
      // 'http://localhost:8081/api/v1/auth/reset-password';
      'http://172.16.1.30:8081/api/v1/auth/reset-password';

  Future<String?> forgotPassword(String email) async {
    try {
      String encodedEmail = Uri.encodeComponent(email);
      final apiUrl = '$baseUrl?email=$encodedEmail';

      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return 'success';
      } else {
        Map<String, dynamic> errorResponse = jsonDecode(response.body);
        return errorResponse[
            'message']; // Return the error message from the server
      }
    } catch (e) {
      print('Error: $e');
      return 'An error occurred'; // You can return any value you want on error
    }
  }
}
