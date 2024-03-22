import 'package:flutter/material.dart';
import 'package:ezd_app/services/product_service.dart';
import 'package:ezd_app/views/product/product_details.dart';

class ListViewProduct extends StatefulWidget {
  final List<Product> products;

  const ListViewProduct({Key? key, required this.products}) : super(key: key);

  @override
  _ListViewState createState() => _ListViewState();
}

class _ListViewState extends State<ListViewProduct> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    // Xóa dòng sau
    // _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      products = await ProductService().getAllProducts();
      setState(() {});
    } catch (e) {
      print('Error loading products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách sản phẩm'),
        backgroundColor: Colors.grey,
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              // Chuyển đến trang chủ khi nhấn nút Home
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (widget.products.isNotEmpty)
                for (int i = 0; i < widget.products.length; i++)
                  _buildProductCard(context, widget.products[i]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProductDetails(userProductId: product.id ?? ''),
          ),
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                product.imgProduct ?? '',
                width: 200,
                height: 200,
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Text(
                      product.name ?? 'Tên không xác định',
                      style: TextStyle(fontSize: 13),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipOval(
                              child: Image.network(
                                product.imgProduct ?? '',
                                width: 30,
                                height: 30,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              product.gameProduct?.nameGame ??
                                  'Game không xác định',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.description ?? 'Không có mô tả.',
                      style: TextStyle(fontSize: 13),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          '${product.price ?? ''}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '/Trận ',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Image.asset("images/dong.png")
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
