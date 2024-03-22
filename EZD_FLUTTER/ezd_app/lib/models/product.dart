class Product {
  String? id;
  String? imgProduct;
  String? price;
  String? hour;
  String? description;
  String? status;
  String? createdDate;
  String? userProduct;
  String? gameProduct;
  String? roleProduct;
  String? levelProduct;
  String? genderProduct;

  Product({
    this.id,
    this.imgProduct,
    this.price,
    this.hour,
    this.description,
    this.status,
    this.createdDate,
    this.userProduct,
    this.gameProduct,
    this.roleProduct,
    this.levelProduct,
    this.genderProduct,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      imgProduct: json['img_product'],
      price: json['price'],
      hour: json['hour'],
      description: json['description'],
      status: json['status'],
      createdDate: json['created_date'],
      userProduct: json['user_product'],
      gameProduct: json['game_product'],
      roleProduct: json['role_product'],
      levelProduct: json['level_product'],
      genderProduct: json['gender_product'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'img_product': imgProduct,
      'price': price,
      'hour': hour,
      'description': description,
      'status': status,
      'created_date': createdDate,
      'user_product': userProduct,
      'game_product': gameProduct,
      'role_product': roleProduct,
      'level_product': levelProduct,
      'gender_product': genderProduct,
    };
  }
}
