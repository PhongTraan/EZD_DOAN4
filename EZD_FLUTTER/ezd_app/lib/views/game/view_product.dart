import 'package:ezd_app/views/auth/colla_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Product {
  final String imagePath;
  final String authorName;
  final String gameName;
  final String title;

  Product({
    required this.imagePath,
    required this.authorName,
    required this.gameName,
    required this.title,
  });
}

class ViewProduct extends StatelessWidget {
  final List<Product> products = [
    Product(
      imagePath: "images/logo.png",
      authorName: "John Doe",
      gameName: "Awesome Game",
      title: "Exciting Adventure",
    ),
    Product(
      imagePath: "images/logo.png",
      authorName: "Jane Smith",
      gameName: "Fantastic Game",
      title: "Epic Battle",
    ),
    // Thêm các sản phẩm khác nếu cần
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            for (int i = 0; i < products.length; i++)
              _buildProductItem(context, products[i]),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(BuildContext context, Product product) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: InkWell(
              onTap: () {
                // Chuyển đến trang CollaPage khi sản phẩm được nhấn
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CollaPage()),
                );
              },
              child: Container(
                alignment: Alignment.center,
                child: Image.asset(
                  product.imagePath,
                  height: 120,
                  width: 150,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Author Name
                        Text(
                          product.authorName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 8),

                        // Game Name
                        Text(
                          product.gameName,
                          style: TextStyle(
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 9),

                        // Title
                        Text(
                          product.title,
                          style: TextStyle(
                            fontSize: 13,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
