import 'package:ezd_app/services/product_service.dart';
import 'package:ezd_app/views/product/product_details.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late List<Product> products = []; // Initialize with an empty list

  @override
  void initState() {
    super.initState();
    _loadProducts();
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (products.isNotEmpty) // Check if products are loaded
              for (int i = 0; i < products.length; i++)
                _buildProductCard(context, products[i]),
          ],
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
                    const SizedBox(height: 8),
                    Text(
                      product.userProduct?.name ?? 'Unknown Name',
                      style: const TextStyle(fontSize: 13),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                product.authAvata?.img ??
                                    'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAIcAAACHCAMAAAALObo4AAAAP1BMVEX///+ZmZmVlZWurq6SkpLy8vKrq6uNjY2mpqb8/Py3t7e8vLyhoaH4+PjZ2dnt7e3Jycnl5eXQ0NDCwsLf399QKmt2AAAEKklEQVR4nO1b27KrIAwVihcUtVr//1uP1F6UQkgAuztnWA/7aZNZTUISklgUGRkZGRkZGRkZGbGQfVmW4ziuf3v5RxzK5dpWDePiDqaq9jqUX+YwDi2vBWcHcC5q1g7jt0iUc8VMDm8yglXzN9QytUw4ODwhWDutvnMmi0HVLk0cUKvhPB5yalAkNgM100k0ytZnEMM87Rl+Iq84i+xVUl+TG2esaMp4MKkS3+KFU5XxZLKkpNHVYSxW1F0y28hLoDI2jVwSEemrGBraSfokNFQcjZWISnCBexXJ4k4kWiOyiaehTRNLI8pF3xCXKBZF56HBuWqqS9UoX3zhXQyRBY4bgt+mzQXL6eYpB+qIgDaCojmbD/89M1AnPDjESzBw8I90CidkXoXGsysktr7ZTkB25NcwGmWA0CukwTosnLWATOFyf+iC8TaExgRZxRkgwfArQkpFKJDWboETZM2GTmOALA3Jg/jzgcwDyrKgOPAHKCoNUL1gHi8hDwEMageYWODsWQEnqVemBGT5ctYNDO+0GDJDl1bMp501Aek2iofHpgZGSFIcD0ZJu7AoT8ICcwwTlBACpZYVsNPDh0k3xlPkweHZU1kLPA0w42tANp48ZwnZf/G87UEHAasnrQ98oQp7miYCHPaexZdlHjddZdmKwg03b58E7agSjGIbXB4yet9d+Hq5978leWMvyDDPUMfRT4BJ7klE2X6VRPUGsBemxAiztb5GVF+To3mgWnLmc877oHtCYDMM/JzcCVTD29T9oLDHUvPQXtINkx7BDB2+a3QCDz1fEHz7gwaaB84/giHS3hfOlGr2UIqhur34++KXpQdPkyFPluPSMkTHF8vD1yLkrHWbeGp9txfdPJQXmEYHO1rpaarh+zFgx0H564cFvMT4whCoP4Q74+8BZH9C/TE4pXDsM2h2/xJ8we6sT2u8DOdvoXSnHHYh0FiJOH4MVFOasDsqUA3aYH9vk94vdqUSu0rSWo2Q3nPW9y25IWyvVUlSLJUy0SoaNsvQJiCWh3ZNb0vLTynE/sdnqgvqSlvCGbGn3MXZ9YEPP+MtUasf/cKAFmzx+fYn9wsLI/cT7fqE6Wfk/qnZjkUXlUcYpS69nyxNlYZNPnvDuAGjoOO8IXCYdHyyB80bDkkmbHRiCCFUQHvss3/w2HNfIwbOow4dpgQ8Qudz+3lluD7eNILnlbtbl4BH4M2/4zXPDki2G24vGlELOi/zqksYVKxCN/zGvkPhKu6oiPDRB40Eazmuph4R5W/sB+l9qbi+TLRRXviN/bEicp8uGYviZ/YL9b5lCBGRet8yfP80/Xrwb+zjavzGfvIKidzX5qfua9+B3l8/Hb+xz3/HOOvvG8yGLRc1/+L3DQ8cvvfg9+89lm9/7/GE/v5l/OPvXzIyMjIyMjIyMv4n/AOcdyyNtf17ywAAAABJRU5ErkJggg==',
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              (product.gameProduct?.nameGame ?? 'Unknown Game')
                                          .length >
                                      10
                                  ? '${(product.gameProduct?.nameGame ?? 'Unknown Game').substring(0, 10)}...'
                                  : (product.gameProduct?.nameGame ??
                                      'Unknown Game'),
                              style: const TextStyle(
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
                      (product.description?.length ?? 0) > 30
                          ? '${product.description!.substring(0, 30)}\n${product.description!.substring(30, min(50, product.description!.length))}${product.description!.length > 50 ? "..." : ""}'
                          : product.description ?? 'No description available.',
                      style: const TextStyle(fontSize: 13),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          '${product.price ?? ''}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          // '/Trận ',
                          "/${product.hour ?? ''}H",
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Image.asset(
                          "images/dong1.jpg",
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
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
