import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  void _signInWithEmailAndPassword() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // If login is successful, navigate to the MonitoringPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage()),
      );
    } catch (e) {
      // Handle login errors
      print("Error signing in: $e");

      setState(() {
        if (e is FirebaseAuthException) {
          switch (e.code) {
            case 'invalid-credential':
              _errorMessage = 'Login failed. Please double-check your email and password and try again';
              break;
            case 'too-many-requests':
              _errorMessage = 'We have detected unusual activity on your account. Please try again later or reset your password';
              break;
            case 'invalid-email':
              _errorMessage = 'Field must be filled out';
              break;
            default:
              _errorMessage = e.message ?? 'An error occurred';
              break;
          }
        } else {
          _errorMessage = 'An error occurred';
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Container(
            padding: const EdgeInsets.all(16),
            height: 90,
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Text(_errorMessage),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
    body: Column(
      children: [
        Container(
          width: 360,
          height: 800,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 16,
                top: 266,
                child: Container(
                  width: 327,
                  height: 236,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 327,
                          height: 236,
                          decoration: ShapeDecoration(
                            color: Color(0xFF164863),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 18,
                        top: 16,
                        child: SizedBox(
                          width: 189,
                          height: 22,
                          child: Text(
                            'Welcome Back, My GEN!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              decoration: TextDecoration.none
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 216,
                        top: 136,
                        child: Container(
                          width: 84,
                          height: 9,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 5,
                                top: 0,
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 6,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                    decoration: TextDecoration.none
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 54,
                                top: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/forgot');
                                  },
                                child: Text(
                                  'Click here',
                                  style: TextStyle(
                                    color: Color(0xFF51A6E4),
                                    fontSize: 6,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                    decoration: TextDecoration.underline
                                  ),
                                ),
                              ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 18,
                        top: 46,
                        child: Container(
                          width: 290,
                          height: 41,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: SizedBox(
                                  width: 75,
                                  height: 16,
                                  child: Text(
                                    'Your Email',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                      decoration: TextDecoration.none
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 18,
                                child: Container(
                                  width: 290,
                                  height: 23,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFD9D9D9),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 9,
                                top: 38,
                                child: Container(
                                  width: 273,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        strokeAlign: BorderSide.strokeAlignCenter,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 9,
                                top: 22,
                                child: SizedBox(
                                  width: 290,
                                  height: 20,
                                  child: TextFormField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      hintText: 'example@email.xyz'
                                    ),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 11,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 18,
                        top: 95,
                        child: Container(
                          width: 290,
                          height: 41,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: SizedBox(
                                  width: 96,
                                  height: 16,
                                  child: Text(
                                    'Your Password',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                      decoration: TextDecoration.none
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 18,
                                child: Container(
                                  width: 290,
                                  height: 23,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFD9D9D9),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 9,
                                top: 38,
                                child: Container(
                                  width: 273,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        strokeAlign: BorderSide.strokeAlignCenter,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 9,
                                top: 22,
                                child: SizedBox(
                                  width: 273,
                                  height: 14,
                                  child: TextField(
                                    controller: _passwordController,
                                    obscureText: true,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 143,
                        top: 202,
                        child: Container(
                          width: 40,
                          height: 23,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 17,
                                top: 0,
                                child: Text(
                                  'Or',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 6,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                    decoration: TextDecoration.none
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 9,
                                child: SizedBox(
                                  width: 40,
                                  height: 14,
                                  child: GestureDetector (
                                    onTap: () {
                                      Navigator.of(context).pushReplacementNamed('/signup');
                                    },
                                  child: Text(
                                    'Sign Up',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF51A6E4),
                                      fontSize: 10,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                      decoration: TextDecoration.underline
                                    ),
                                  ),
                                ),
                              ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (_errorMessage.isNotEmpty)
                      Positioned(
                        left: 16,
                        top: 510,
                        child: Text(
                          _errorMessage,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.none
                          ),
                        ),
                      ),
                      Positioned(
                        left: 87,
                        top: 169,
                        child: GestureDetector(
                          onTap: _signInWithEmailAndPassword,
                        child: Container(
                          width: 152,
                          height: 29,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 152,
                                  height: 29,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF427D9D),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 46,
                                top: 6,
                                child: SizedBox(
                                  width: 60,
                                  height: 17,
                                  child: Text(
                                    'LOG IN',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                      decoration: TextDecoration.none
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 105,
                top: 104,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/img/logo_app2.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 360,
                  height: 31,
                  decoration: BoxDecoration(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    );
  }
}