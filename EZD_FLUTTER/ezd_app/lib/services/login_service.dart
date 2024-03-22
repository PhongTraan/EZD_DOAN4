import 'dart:convert';
import 'package:ezd_app/models/auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  // static const storage = FlutterSecureStorage();
  FlutterSecureStorage storage = FlutterSecureStorage();
  // static const String apiUrl = 'http://localhost:8081/api/v1/auth/signin';
  // static const String apiUrl = 'http://localhost:8081/api/v1/auth/signin';
  static const String apiUrl = 'http://172.16.1.30:8081/api/v1/auth/signin';

  // static const String apiUrl = 'http://192.168.1.4:8081/api/v1/auth/signin';

  Future<String?> login(String email, String password) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      'email': email,
      'password': password,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        String token = data['token'];
        String refreshToken = data['refreshToken'];
        await _saveUserData(email, password, token); // Lưu thông tin người dùng
        return 'success';
      } else {
        print('Login failed: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<void> _saveUserData(
      String email, String password, String token) async {
    try {
      await storage.write(key: 'email', value: email);
      await storage.write(key: 'password', value: password);
      await storage.write(key: 'token', value: token);
    } catch (e) {
      print('Error saving user data: $e');
      throw Exception('Error saving user data');
    }
  }

  Future<LoginModel?> getUserData({String? token}) async {
    try {
      String? email = await storage.read(key: 'email');

      if (email == null) {
        // Không có email được lưu, không thể lấy thông tin người dùng
        print('No email stored');
        return null;
      }

      final response = await http.get(
        Uri.parse('http://localhost:8081/api/v1/auth/findByEmail?email=$email'),
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> userDataMap = jsonDecode(response.body);
        LoginModel userData = LoginModel.fromJson(userDataMap);
        print('User data: $userData');
        return userData;
      } else {
        print('Failed to fetch user data: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to fetch user data');
      }
    } catch (e) {
      print('Error getting user data: $e');
      throw Exception('Error getting user data');
    }
  }
}
