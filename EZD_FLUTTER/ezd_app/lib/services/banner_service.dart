import 'dart:convert';
import 'package:http/http.dart' as http;

class BannerService {
  // static const String apiUrl = 'http://localhost:8081/api/v1/auth/signin';
  // static const String apiUrl = 'http://localhost:8081';
  // static const String apiUrl = 'http://172.16.1.30:8081/api/v1/auth/signin';

  // static const String apiUrl = 'http://192.168.1.4:8081';
  static const String apiUrl = 'http://172.16.1.30:8081';

  Future<List<Banner>> getAllBanners() async {
    final response = await http.get(Uri.parse('$apiUrl/api/banners/'));

    if (response.statusCode == 200) {
      // Decode JSON với UTF-8 encoding
      List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));
      List<Banner> banners =
          jsonList.map((json) => Banner.fromJson(json)).toList();
      return banners;
    } else {
      throw Exception('Failed to load list Banner');
    }
  }
}

class Banner {
  final String image;

  Banner({
    required this.image,
  });

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      image: json['image'],
    );
  }
}
