class LoginModel {
  final String? id;
  final String? email;
  final String? password;
  final String? username;
  final String? address;
  final String? phone;
  final DateTime? birthday;
  final String avatars;

  LoginModel({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.address,
    required this.phone,
    required this.birthday,
    required this.avatars,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      address: json['address'],
      phone: json['phone'],
      birthday:
          json['birthday'] != null ? DateTime.parse(json['birthday']) : null,
      avatars: json['avatars'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      'username': username,
      'email': email,
      'password': password,
      'address': address,
      'phone': phone,
      'birthday': birthday?.toIso8601String(),
      'avatars': avatars,
    };
  }
}
