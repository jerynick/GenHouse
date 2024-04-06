import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gen_house/screens/splashscreen.dart';
import 'package:gen_house/screens/loginpage.dart';
import 'package:gen_house/screens/dashboard.dart';
import 'package:gen_house/screens/settings.dart';
import 'package:gen_house/screens/genkey.dart';
import 'package:gen_house/screens/signup.dart';
import 'package:gen_house/screens/forgotpass.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyCOjYbqOPx6VgIsvjK-cNiXcQArjnEVBvg',
      appId: '1:961677687907:android:128ed945e2783f78328c56',
      messagingSenderId: '961677687907',
      projectId: 'genhousedb',
      databaseURL: 'https://genhousedb-default-rtdb.asia-southeast1.firebasedatabase.app',
      storageBucket: 'genhousedb.appspot.com',
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      // Rute-rute aplikasi didefinisikan di sini
      routes: {
        '/': (context) => SplashScreen(),
        '/dashboard':(context) => DashboardPage(),
        '/settings':(context) =>  SettingsPage(),
        '/genkeyset': (context) => GenkeyPage(),
        '/login':(context) => LoginPage(),
        '/signup':(context) => SignUpPage(),
        '/forgot':(context) => ForgotPassPage(),
      },
      initialRoute: '/', // Rute awal saat aplikasi dimulai
    );
  }
}