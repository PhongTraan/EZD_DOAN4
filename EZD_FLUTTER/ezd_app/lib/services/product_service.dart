import 'dart:convert';
import 'package:ezd_app/services/login_service.dart';
import 'package:http/http.dart' as http;

class ProductService {
  // static const String apiUrl = 'http://localhost:8081';
  static const String apiUrl = ' http://172.16.1.30:8081';

  Future<List<Product>> getAllProducts() async {
    final response = await http.get(Uri.parse('$apiUrl/api/products/'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));
      List<Product> products =
          jsonList.map((json) => Product.fromJson(json)).toList();
      return products;
    } else {
      throw Exception('Failed to load list of Products');
    }
  }

  // FindBy User Name
  Future<List<Product>> searchProductsByNameAndRouter(String name) async {
    final response =
        await http.get(Uri.parse('$apiUrl/api/products/byName/$name'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));
      List<Product> products =
          jsonList.map((json) => Product.fromJson(json)).toList();
      return products;
    } else {
      throw Exception('Failed to load list of Products');
    }
  }

  Future<List<Product>> searchProductsByGameName(String gameName) async {
    final response =
        await http.get(Uri.parse('$apiUrl/api/products/byGameName/$gameName'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));
      List<Product> products =
          jsonList.map((json) => Product.fromJson(json)).toList();
      return products;
    } else {
      throw Exception('Failed to load list of Products');
    }
  }

  // Findby Id UserName
  Future<Product?> getProductById(String id) async {
    final response = await http.get(Uri.parse('$apiUrl/api/products/$id'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMap =
          json.decode(utf8.decode(response.bodyBytes));
      Product product = Product.fromJson(jsonMap);
      return product;
    } else {
      throw Exception('Failed to load Product by ID');
    }
  }
}

class Product {
  String? id;
  String? name;
  User? userProduct;
  Game? gameProduct;

  String? roleProduct;
  Level? levelProduct;
  Gender? genderProduct;
  String? imgProduct;
  double? price;
  int? hour;
  String? description;
  String? status;
  DateTime? createdDate;
  Rank? rankProduct;

  AuthAvata? authAvata;

  Product({
    this.id,
    this.name,
    this.userProduct,
    this.gameProduct,
    this.roleProduct,
    this.levelProduct,
    this.genderProduct,
    this.imgProduct,
    this.price,
    this.hour,
    this.description,
    this.status,
    this.createdDate,
    this.rankProduct,
    this.authAvata,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id']?.toString(),
      name: json['name']?.toString(),
      userProduct: json['user_product'] != null
          ? User.fromJson(json['user_product'])
          : null,
      gameProduct: json['game_product'] != null
          ? Game.fromJson(json['game_product'])
          : null,
      roleProduct: json['role_product']?['name']?.toString(),
      levelProduct: json['level_product'] != null
          ? Level.fromJson(json['level_product'])
          : null,
      genderProduct: json['gender_product'] != null
          ? Gender.fromJson(json['gender_product'])
          : null,
      imgProduct: json['img_product']?.toString(),
      price: json['price']?.toDouble(),
      hour: json['hour'] as int?,
      description: json['decription']?.toString(),
      status: json['status']?.toString(),
      createdDate: json['created_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['created_date'])
          : null,
      rankProduct: json['rank_product'] != null
          ? Rank.fromJson(json['rank_product'])
          : null,
      authAvata: json['auth_avata'] != null
          ? AuthAvata.fromJson(json['auth_avata'])
          : null,
    );
  }
}

class User {
  String? id;
  String? name;
  String? email;
  List<String>? avatars;
  String? authAvataId; // Add this line

  User({this.id, this.name, this.email, this.avatars, this.authAvataId});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      name: json['name'],
      email: json['email'],
      avatars:
          json['avatars'] != null ? List<String>.from(json['avatars']) : null,
      authAvataId: json['auth_avata'] != null
          ? AuthAvata.fromJson(json['auth_avata']).id
          : null,
    );
  }
}

class Game {
  String? id;
  String? nameGame;
  String? imageName;

  Game({this.id, this.nameGame, this.imageName});

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'].toString(),
      nameGame: json['nameGame'],
      imageName: json['imageName'],
    );
  }
}

class Level {
  String? id;
  String? name;

  Level({this.id, this.name});

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      id: json['id'].toString(),
      name: json['name'],
    );
  }
}

class Gender {
  String? id;
  String? name;

  Gender({this.id, this.name});

  factory Gender.fromJson(Map<String, dynamic> json) {
    return Gender(
      id: json['id'].toString(),
      name: json['name'],
    );
  }
}

class Rank {
  String? id;
  String? name;

  Rank({this.id, this.name});

  factory Rank.fromJson(Map<String, dynamic> json) {
    return Rank(
      id: json['id']?.toString(),
      name: json['name']?.toString(),
    );
  }
}

class AuthAvata {
  String? id;
  String? img;

  AuthAvata({this.id, this.img});

  factory AuthAvata.fromJson(Map<String, dynamic> json) {
    return AuthAvata(
      id: json['id']?.toString(),
      img: json['img']?.toString(),
    );
  }
}
