import 'dart:convert';
import 'package:http/http.dart' as http;

class GameService {
  // static const String apiUrl = 'http://localhost:8081/api/v1/auth/signin';
  // static const String apiUrl = 'http://localhost:8081';
  // static const String apiUrl = 'http://172.16.1.30:8081/api/v1/auth/signin';

  // static const String apiUrl = 'http://192.168.1.4:8081';
  static const String apiUrl = 'http://172.16.1.30:8081';

  Future<List<Game>> getAllGames() async {
    final response = await http.get(Uri.parse('$apiUrl/api/games/'));

    if (response.statusCode == 200) {
      // Decode JSON với UTF-8 encoding
      List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));
      List<Game> games = jsonList.map((json) => Game.fromJson(json)).toList();
      return games;
    } else {
      throw Exception('Failed to load games');
    }
  }
}

class Game {
  final int id;
  final String nameGame;
  final String imageName;

  Game({
    required this.id,
    required this.nameGame,
    required this.imageName,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      nameGame: json['nameGame'],
      imageName: json['imageName'],
    );
  }
}
