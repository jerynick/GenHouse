import 'package:gen_house/screens/loginpage.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Delay untuk simulasi splash screen
    Future.delayed(Duration(seconds: 2), () {
      // Navigasi ke StartPage setelah selesai splash screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });

    return Scaffold(
      body: Column(
      children: [
        Container(
          width: 360,
          height: 800,
          padding: const EdgeInsets.only(top: 35),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 360,
                height: 800,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/img/splash_screen.png"),
                    fit: BoxFit.contain,
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

void main() {
  runApp(MaterialApp(
    home: SplashScreen(),
  ));
}