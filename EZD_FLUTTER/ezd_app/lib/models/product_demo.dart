class Product {
  final String imagePath;
  final String authName;
  final String gameName;
  final String title;
  final double rating;

  Product({
    required this.imagePath,
    required this.authName,
    required this.gameName,
    required this.title,
    required this.rating,
  });
}

List<Product> generateDemoProducts() {
  return [
    Product(
      imagePath: "images/logo.png",
      authName: "Author 1",
      gameName: "Game 1",
      title: "Title 1",
      rating: 4.0,
    ),
    Product(
      imagePath: "images/logo.png",
      authName: "Author 2",
      gameName: "Game 2",
      title: "Title 2",
      rating: 4.5,
    ),
    // Thêm các sản phẩm khác nếu cần
  ];
}
