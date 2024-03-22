import 'package:ezd_app/views/account/account.dart';
import 'package:ezd_app/views/auth/login.dart';
import 'package:ezd_app/views/home/home_page.dart';
import 'package:ezd_app/views/product/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class SizebarPage extends StatefulWidget {
  const SizebarPage({Key? key}) : super(key: key);

  @override
  _SizebarPageState createState() => _SizebarPageState();
}

class _SizebarPageState extends State<SizebarPage> {
  int _currentIndex = 0;
  bool isLoggedInChecked = false; // Theo dõi đã kiểm tra đăng nhập hay chưa
  bool isLoggedIn = false; // Theo dõi trạng thái đăng nhập

  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    String? savedEmail = await storage.read(key: 'email');
    setState(() {
      isLoggedIn = savedEmail != null;
      isLoggedInChecked = true; // Đã kiểm tra đăng nhập
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Mỗi trang nằm ở dưới cùng
          IndexedStack(
            index: _currentIndex,
            children: [
              HomePage(), // 0
              // Container(color: Colors.blue), // Ví dụ trang category (1)
              ProductPage(),
              // Container(color: Colors.orange), // Ví dụ trang account (3)
              Account(),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SnakeNavigationBar.color(
              // ... (các thuộc tính khác của SnakeNavigationBar)
              behaviour: SnakeBarBehaviour.floating,
              snakeShape: SnakeShape.circle,
              padding: const EdgeInsets.symmetric(vertical: 5),
              unselectedLabelStyle: const TextStyle(fontSize: 11),
              selectedItemColor: Colors.grey,
              snakeViewColor: Color.fromARGB(255, 204, 204, 204),
              unselectedItemColor: Colors.grey,
              showSelectedLabels: true,
              currentIndex: _currentIndex,
              onTap: (index) async {
                setState(() {
                  _currentIndex = index;
                });

                // Kiểm tra trạng thái đăng nhập
                if (isLoggedInChecked) {
                  // Nếu đã kiểm tra và chưa đăng nhập, chuyển đến trang đăng nhập
                  if (!isLoggedIn && index == 2) {
                    // Only replace the route if the user is not already logged in
                    final bool loginSuccess = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );

                    if (loginSuccess) {
                      // Update the login status after a successful login
                      _checkLoginStatus();
                    }
                    return;
                  }
                }
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category), label: 'Category'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: 'Account',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
