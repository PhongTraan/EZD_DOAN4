import 'package:ezd_app/services/product_service.dart';
import 'package:ezd_app/views/home/home_page.dart';
import 'package:ezd_app/views/navbar/list_view.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _textEditingController;
  bool _showNotFoundMessage = false;
  List<Product> products = [];

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _handleSearch() async {
    String searchText = _textEditingController.text.trim();
    if (searchText.isNotEmpty) {
      try {
        List<Product> searchResults =
            await ProductService().searchProductsByNameAndRouter(searchText);

        setState(() {
          products = searchResults;
          _showNotFoundMessage = searchResults.isEmpty;
        });

        // Nếu có kết quả từ tìm kiếm, chuyển hướng đến trang ListView
        if (searchResults.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListViewProduct(products: searchResults),
            ),
          );
        }
      } catch (e) {
        print('Error searching products: $e');
      }
    } else {
      // Nếu không có kết quả tìm kiếm, đặt _showNotFoundMessage thành true.
      setState(() {
        _showNotFoundMessage = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    if (context != null) {
                      Navigator.push(
                        context!,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                    }
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Nhập name để tìm kiếm người chơi',
                      filled: true,
                      fillColor: const Color.fromARGB(255, 190, 131, 201)
                          .withOpacity(0.1),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          width: 1,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: Color.fromARGB(255, 76, 86, 175),
                        ),
                        onPressed: _handleSearch,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: _showNotFoundMessage,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Không tìm thấy kết quả. Vui lòng thử lại.',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Hiển thị danh sách kết quả tìm kiếm
            if (!_showNotFoundMessage && products.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(products[index].name ?? ''),
                      // Add other details as needed
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
