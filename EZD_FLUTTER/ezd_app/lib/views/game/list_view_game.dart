import 'package:ezd_app/services/product_service.dart';
import 'package:flutter/material.dart';

class ListViewGame extends StatefulWidget {
  const ListViewGame({Key? key}) : super(key: key);

  @override
  _ListViewGameState createState() => _ListViewGameState();
}

class _ListViewGameState extends State<ListViewGame> {
  List<Product> products = [];
  final ProductService productService = ProductService();
  bool _isMounted = false;

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    _loadProducts();
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  Future<void> _loadProducts() async {
    try {
      List<Product> fetchedProducts = await productService.getAllProducts();

      // Check if the widget is still mounted before calling setState
      if (_isMounted) {
        setState(() {
          products = fetchedProducts;
        });
      }
    } catch (e) {
      print('Error loading products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        child: Row(
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
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Column(
          children: [
            // Display image from URL
            Image.network(
              product.imgProduct ?? '', // Modify this according to your data
              width: 80,
              height: 80,
            ),
            const SizedBox(height: 8),
            Text(
              truncateText(
                  product.name ?? '', 10), // Modify this according to your data
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return text.substring(0, maxLength - 3) + "...";
    }
  }
}
