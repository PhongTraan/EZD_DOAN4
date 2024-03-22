import 'package:flutter/material.dart';
import 'package:ezd_app/services/product_service.dart';
import 'package:ezd_app/views/product/comment.dart';

class ProductDetails extends StatefulWidget {
  final String userProductId;

  const ProductDetails({Key? key, required this.userProductId})
      : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late Product product;

  @override
  void initState() {
    super.initState();
    product = Product(); // Initialize with a default value
    _loadProduct();
  }

  Future<void> _loadProduct() async {
    try {
      product = await ProductService().getProductById(widget.userProductId) ??
          Product();
      setState(() {});
    } catch (e) {
      print('Error loading product: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (product.id == null) {
      // Product is not loaded yet, return a loading indicator or handle accordingly
      return CircularProgressIndicator(); // Example of a loading indicator, replace with your own logic
    }
    return Scaffold(
      appBar: AppBar(
        // title: Text('Chi tiết sản phẩm'),
        backgroundColor: Colors.grey,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "images/logo.png",
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
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
                  const SizedBox(width: 16),
                  Text(
                    product.userProduct?.name ?? "",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${product.gameProduct?.nameGame ?? ''}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Image.asset(
                          "images/dong1.jpg",
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "${product.price ?? " "}",
                          style: TextStyle(
                            fontSize: 14,
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
                        )
                      ],
                    ),
                    const SizedBox(height: 13),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                "Đánh giá: 5 ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(width: 60),
                              Text(
                                "Đã phục vụ : 1000",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(width: 8),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: 420,
                      child: Text(
                        "${product.description}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Text(
                "Thông tin kĩ năng",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            product.imgProduct ?? '',
                            width: 400,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Hạng: ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "${product.levelProduct?.name ?? ''}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "Vị trí: ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          // product.position ?? '',
                          "5000",
                          // "${product.levelProduct?.name ?? ''}",
                          // "{$}"
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                "Comment",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const CommentList(),
            ],
          ),
        ),
      ),
    );
  }
}
