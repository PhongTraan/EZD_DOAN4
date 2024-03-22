import 'package:ezd_app/services/login_service.dart';
import 'package:ezd_app/views/auth/forgot_pass.dart';
import 'package:ezd_app/views/auth/register_page.dart';
import 'package:ezd_app/views/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool isPasswordVisible = true;
  bool _isLoading = false;

  final storage = FlutterSecureStorage();

  // Thêm biến để theo dõi trạng thái đã kiểm tra đăng nhập hay chưa
  bool isLoggedInChecked = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    String email = emailController.text;
    String password = passController.text;

    try {
      AuthService authService = AuthService();
      final response = await authService.login(email, password);

      if (response != null && response == 'success') {
        // Lưu thông tin đăng nhập vào FlutterSecureStorage
        await storage.write(key: 'email', value: email);

        // Hiển thị snackbar thành công bằng Get
        Get.snackbar(
          'Success',
          'Login successful',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );

        // Điều hướng đến HomePage sau khi đăng nhập thành công
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        // Hiển thị snackbar lỗi bằng Get
        Get.snackbar(
          'Error',
          'Invalid email or password',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      }
    } catch (e) {
      // Hiển thị snackbar lỗi bằng Get
      Get.snackbar(
        'Error',
        'An error occurred. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
    } finally {
      setState(() {
        _isLoading = false;
        isLoggedInChecked = true; // Đã kiểm tra đăng nhập
      });
    }
  }

  // Hàm để kiểm tra và đăng nhập tự động từ FlutterSecureStorage
  Future<void> _tryAutoLogin() async {
    String? savedEmail = await storage.read(key: 'email');

    if (savedEmail != null) {
      // Nếu có thông tin đăng nhập đã lưu, thực hiện đăng nhập tự động
      emailController.text = savedEmail;
      _login();
    }
  }

  @override
  void initState() {
    super.initState();
    _tryAutoLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 105, 54, 146),
                Color.fromARGB(255, 134, 77, 182),
                Color.fromARGB(255, 154, 98, 199),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              ClipOval(
                child: Image.asset(
                  "images/logo1.png",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 30),
              Text(
                "EZD",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              Container(
                height: 600,
                width: 370,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "Hello",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Please login to Your Account",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 250,
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Enter Email",
                            suffixIcon: Icon(
                              Icons.email,
                              size: 13,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email address';
                            } else if (!RegExp(
                                    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                                .hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        width: 250,
                        child: TextFormField(
                          controller: passController,
                          obscureText: !isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: "Enter Password",
                            suffixIcon: IconButton(
                              icon: Icon(
                                isPasswordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 40, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                // Điều hướng đến màn hình đăng ký (signup)
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ForgotPass(),
                                  ),
                                );
                              },
                              child: Text(
                                "Forgot Password",
                                style: TextStyle(
                                  color: Colors.orangeAccent[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            // Thực hiện đăng nhập khi form hợp lệ
                            _login();
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 250,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color.fromARGB(255, 105, 54, 146),
                                Color.fromARGB(255, 134, 77, 182),
                                Color.fromARGB(255, 154, 98, 199),
                              ],
                            ),
                          ),
                          child: _isLoading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          // Điều hướng đến màn hình đăng ký (signup)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 250,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color.fromARGB(255, 141, 145, 107),
                                Color.fromARGB(255, 131, 119, 64),
                                Color.fromARGB(255, 199, 138, 98),
                              ],
                            ),
                          ),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
