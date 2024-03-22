import 'package:ezd_app/views/account/account.dart';
import 'package:ezd_app/views/auth/colla_page.dart';
import 'package:ezd_app/views/auth/forgot_pass.dart';
import 'package:ezd_app/views/auth/login.dart';
import 'package:ezd_app/views/auth/register_page.dart';
import 'package:ezd_app/views/game/game_page.dart';
import 'package:ezd_app/views/home/home_page.dart';
import 'package:ezd_app/views/navbar/sizebar_page.dart';
import 'package:ezd_app/views/product/product_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      color: Color.fromARGB(255, 243, 234, 234),
      // home: LoginPage(),
      // home: RegisterPage(),
      // home: SearchPage(),
      // home: HomePage(),
      // home: GamePage(),
      // home: SizebarPage(),
      // home: CollaPage(),
      // home: Login(),
      // home: Account(),
      // home: ProductPage(),
      // home: ForgotPass(),

      home: SizebarPage(),
    );
  }
}
