import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isEmailValid = false;
  bool _isLoginFailed = false;

  List<Map<String, dynamic>> admins = [];
  List<Map<String, dynamic>> supervisors = [];

  @override
  void initState() {
    super.initState();
    fetchAdmins();
    fetchSupervisors();
  }

  Future<void> fetchAdmins() async {
    final response = await http.get(Uri.parse('http://localhost:8080/admins')); // Replace '/admin' with your endpoint
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      setState(() {
        admins = responseData.map((adminData) => adminData as Map<String, dynamic>).toList();
      });
    } else {
      print('Failed to fetch admins: ${response.statusCode}');
    }
  }

  Future<void> fetchSupervisors() async {
    final response = await http.get(Uri.parse('http://localhost:8080/superviseurs')); // Replace '/superviseur' with your endpoint
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      setState(() {
        supervisors = responseData.map((supervisorData) => supervisorData as Map<String, dynamic>).toList();
      });
    } else {
      print('Failed to fetch supervisors: ${response.statusCode}');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    final enteredEmail = _emailController.text;
    final enteredPassword = _passwordController.text;


    final adminUser = admins.firstWhereOrNull((admin) =>
    admin['email_admin'] == enteredEmail &&
        admin['mdp_admin'] == enteredPassword);

    final supervisorUser = supervisors.firstWhereOrNull((supervisor) =>
    supervisor['email_sup'] == enteredEmail &&
        supervisor['mdp_sup'] == enteredPassword);

    if (adminUser != null) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('userType', 'admin');
      prefs.setString('adminInfo', jsonEncode(adminUser));
      Get.offAll(() => NavScreen(isAdmin: true));
    } else if (supervisorUser != null) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setInt('supervisorID', supervisorUser['id_sup']);
      final supervisorID = prefs.getInt('supervisorID');
      print('Supervisor ID saved in SharedPreferences: $supervisorID');

      Get.offAll(() => NavScreen(isAdmin: false));
    } else {

      setState(() {
        _isLoginFailed = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.45, 1.0],
                colors: [
                  Color.fromRGBO(165, 165, 224, 1),
                  Color.fromRGBO(151, 220, 233, 1),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 60.0, left: 22),
              child: Text(
                'Welcome\nSign in!',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            setState(() {
                              _isEmailValid = false;
                            });
                            return 'Please enter Email';
                          } else {
                            final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                            setState(() {
                              _isEmailValid = emailRegex.hasMatch(value);
                            });
                            if (!_isEmailValid) {
                              return 'Please enter a valid email address';
                            }
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            _isEmailValid ? Icons.check : Icons.check_circle_outline,
                            color: _isEmailValid ? Colors.green : Colors.grey,
                          ),
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF004AAD),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Password';
                          }
                          return null;
                        },
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF004AAD),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      if (_isLoginFailed) // Show error message if login failed
                        Text(
                          'Invalid credentials',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 17,
                            color: Color(0xFF004AAD),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 70),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            login();
                          }
                        },
                        child: Container(
                          height: 60,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(165, 165, 224, 1),
                                Color.fromRGBO(151, 220, 233, 1),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'SIGN IN',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 160),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
