import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPassPage extends StatefulWidget {
  ForgotPassPage({super.key});

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {

  final TextEditingController _forgotController = TextEditingController();
  String _errorMessage = '';

  void _resetpass(BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _forgotController.text
      );
      Navigator.pop(context, '/login');
    } catch (e) {
      print("Error signing in: $e");

      setState(() {
        if (e is FirebaseAuthException) {
          if (e.code == 'too-many-requests') {
            _errorMessage = 'We have detected unusual activity on your account. Please try again later or reset your password';
          } if (e.code == 'invalid-email') {
            _errorMessage = 'Field must be filled out';
          }
          else {
            _errorMessage = e.message ?? 'An error occurred';
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
            child:Text(_errorMessage),
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
                left: 13,
                top: 237,
                child: Container(
                  width: 327,
                  height: 140,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 327,
                          height: 140,
                          decoration: ShapeDecoration(
                            color: Color(0xFF164863),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 22,
                        top: 16,
                        child: SizedBox(
                          width: 169,
                          height: 22,
                          child: Text(
                            'Forgot Password',
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
                        left: 22,
                        top: 42,
                        child: Container(
                          width: 290,
                          height: 41,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: SizedBox(
                                  width: 93,
                                  height: 14,
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
                                top: 37,
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
                                    controller: _forgotController,
                                    decoration: InputDecoration (
                                      hintText: 'example@email.xyz',
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
                        left: 87,
                        top: 97,
                        child: GestureDetector(
                          onTap: () {
                            _resetpass(context);
                          },
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
                                left: 60,
                                top: 6,
                                child: Text(
                                  'SEND',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                    decoration: TextDecoration.none,
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
                left: 0,
                top: 0,
                child: Container(
                  width: 360,
                  height: 31,
                  decoration: BoxDecoration(color: Colors.black),
                ),
              ),
              Positioned(
                left: 105,
                top: 87,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/img/logo_app2.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 132,
                top: 363,
                child: Text(
                  'Check your email message after it!!',
                  style: TextStyle(
                    color: Color(0xFFFFC809),
                    fontSize: 6,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 0,
                    decoration: TextDecoration.none
                  ),
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