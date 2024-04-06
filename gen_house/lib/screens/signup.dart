import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final TextEditingController _signupemailController = TextEditingController();
  final TextEditingController _signuppasswordController = TextEditingController();
  String _errorMessage = '';


  void _register(BuildContext context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _signupemailController.text, 
        password: _signuppasswordController.text,
      );
      Navigator.of(context).pushReplacementNamed('/login');
    } catch (e) {
        // Handle login errors
        print("Error signing in: $e");
        // You can display an error message here

        setState(() {
          if (e is FirebaseAuthException) {
            if (e.code == 'email-already-in-use') {
              _errorMessage = 'This email address is already registered. Please log in instead or use a different email address to sign up.';
            } 
            if (e.code == 'invalid-email') {
              _errorMessage = 'Please enter a valid email address';
            }
            if (e.code == 'channel-error') {
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

  void _discardChange() {
      _signupemailController.clear();
      _signuppasswordController.clear();
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
                    height: 218,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 327,
                            height: 218,
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
                              'Register Form',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 0,
                                decoration: TextDecoration.none,
                              ),
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
                                        decoration: TextDecoration.none,
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
                                      controller: _signupemailController,
                                      decoration: InputDecoration(
                                        hintText: 'example@email.xyz'
                                      ),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 11,
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
                                    child: TextFormField(
                                      controller: _signuppasswordController,
                                      obscureText: true,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
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
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 105,
                  top: 116,
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
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 360,
                    height: 31,
                    decoration: BoxDecoration(color: Colors.black),
                  ),
                ),
                Positioned(
                  left: 34,
                  top: 423,
                  child: Container(
                    width: 290,
                    height: 29,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 150,
                          top: 0,
                          child: GestureDetector(
                            onTap: () {
                              _register(context);
                            },
                          child: Container(
                            width: 140,
                            height: 29,
                            decoration: ShapeDecoration(
                              color: Color(0xFF9D4242),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          child: Center(
                            child:
                            Text(
                              'SUBMIT',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 0,
                                decoration: TextDecoration.none
                              )
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      child: GestureDetector(
                        onTap: () {
                          _discardChange();
                        }, 
                                  
                      child: Container(
                        width: 142,
                        height: 29,
                        decoration: ShapeDecoration(
                          color: Color(0xFF427D9D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      child: Center(
                        child: Text(
                          'DISCARD',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 0,
                            decoration: TextDecoration.none
                          ),
                        ), 
                      )
                    ),
                  ),
                ),
              ],
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