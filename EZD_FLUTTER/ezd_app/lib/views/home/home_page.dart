import 'package:ezd_app/views/game/game_page.dart';
import 'package:ezd_app/views/navbar/search_page.dart';
import 'package:ezd_app/views/navbar/sizebar_page.dart';
import 'package:ezd_app/views/product/product_page.dart';
import 'package:flutter/material.dart';

import 'package:ezd_app/views/Banner/banner.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 194, 190, 190),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Form(
                key: GlobalKey<FormState>(),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset(
                            "images/logo.gif",
                            height: 40,
                            width: 60,
                            fit: BoxFit
                                .cover, // Đảm bảo ảnh được hiển thị đúng trong clip
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SearchPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const BannerPage(),
                    const SizedBox(height: 15),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Những Dịch Vụ Nổi Bật",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),

                    const SizedBox(height: 10),

                    //Game Page
                    const GamePage(),

                    const SizedBox(height: 20),

                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Game được đề xuất",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),

                    // ViewProduct()
                    const ProductPage()
                  ],
                ),
              ),
            ),
            // const Flexible(
            //   child: SizebarPage(),
            // ),
          ],
        ),
      ),
    );
  }
}
