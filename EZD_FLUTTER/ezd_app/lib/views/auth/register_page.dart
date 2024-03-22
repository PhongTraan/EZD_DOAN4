import 'package:ezd_app/services/register_service.dart';
import 'package:ezd_app/views/auth/login.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final usernameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final birthdayController = TextEditingController();
  bool passToggler = true;

  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _register() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    String email = emailController.text;
    String password = passController.text;
    String username = usernameController.text;
    String address = addressController.text;
    String phone = phoneController.text;
    String birthdayString = birthdayController.text;
    DateTime? birthday;

    if (birthdayString.isNotEmpty) {
      // Convert the birthday string to DateTime
      birthday = DateTime.parse(birthdayString);
    }

    try {
      RegisterService registerService = RegisterService();
      final response = await registerService.register(
        username,
        email,
        password,
        address,
        phone,
        birthday,
      );

      if (response != null && response == 'success') {
        // Registration successful, navigate to the login screen
        print('Registration successful');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
        );
      } else {
        // Registration failed, handle logic here
        print('Registration failed');
        setState(() {
          _errorMessage = 'Registration failed. Please try again.';
        });
      }
    } catch (e) {
      // Handle API errors or undefined errors
      print('Error: $e');
      setState(() {
        _errorMessage = 'An error occurred. Please try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(currentDate.year - 100),
      lastDate: currentDate,
    );

    if (pickedDate != null) {
      setState(() {
        birthdayController.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  String? _validateBirthday(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your birthday';
    }

    DateTime birthdayDate = DateTime.parse(value);
    DateTime minimumDate = DateTime.now().subtract(Duration(days: 16 * 365));
    DateTime maximumDate = DateTime.now().subtract(Duration(days: 50 * 365));

    if (birthdayDate.isAfter(minimumDate) ||
        birthdayDate.isBefore(maximumDate)) {
      return 'Must be between 16 and 50 years old';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
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
                      height: 750,
                      width: 370,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: "Enter Email",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                prefixIcon: Icon(Icons.email),
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
                            SizedBox(height: 15),
                            TextFormField(
                              controller: usernameController,
                              decoration: InputDecoration(
                                labelText: "Enter Username",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                prefixIcon: Icon(Icons.person),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a username';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              obscureText: passToggler,
                              controller: passController,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                labelText: "Enter Password",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                prefixIcon: Icon(Icons.lock),
                                suffix: InkWell(
                                  onTap: () {
                                    setState(() {
                                      passToggler = !passToggler;
                                    });
                                  },
                                  child: Icon(
                                    passToggler
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a password';
                                } else if (value.length < 6 ||
                                    value.length > 18) {
                                  return 'Password must be between 6 and 18 characters';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: addressController,
                              decoration: InputDecoration(
                                labelText: "Enter Address",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                prefixIcon: Icon(Icons.location_on),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your address';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: phoneController,
                              decoration: InputDecoration(
                                labelText: "Enter Phone",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                prefixIcon: Icon(Icons.phone),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your phone number';
                                } else if (!RegExp(r'^[0-9]{10}$')
                                    .hasMatch(value)) {
                                  return 'Please enter a valid 10-digit phone number';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 30),
                            TextFormField(
                              readOnly: true,
                              controller: birthdayController,
                              onTap: () => _selectDate(context),
                              decoration: InputDecoration(
                                labelText: "Enter Birthday",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                prefixIcon: Icon(Icons.cake),
                              ),
                              validator: _validateBirthday,
                            ),
                            SizedBox(height: 30),
                            InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  // Form is valid, proceed with registration
                                  _register();
                                }
                              },
                              child: Container(
                                height: 40,
                                width: 200,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 105, 54, 146),
                                      Color.fromARGB(255, 134, 77, 182),
                                      Color.fromARGB(255, 154, 98, 199),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                  // border: Border.all(
                                  //   color: Colors.black,
                                  // ),
                                ),
                                child: Center(
                                  child: _isLoading
                                      ? CircularProgressIndicator()
                                      : Text(
                                          "Register",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color:
                                        const Color.fromARGB(255, 31, 22, 22),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Navigate to the login screen
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Login(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Log In",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (_errorMessage.isNotEmpty)
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  _errorMessage,
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
