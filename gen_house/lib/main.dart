import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:gen_house/dashboard/splashscreen.dart';
import 'package:gen_house/dashboard/loginpage.dart';
import 'package:gen_house/dashboard/dashboard.dart';
import 'package:gen_house/settings/settings.dart';
import 'package:gen_house/settings/genkey.dart';
import 'package:gen_house/dashboard/signup.dart';
import 'package:gen_house/settings/forgotpass.dart';
import 'package:gen_house/services/firebase_options.dart';// Pastikan ini mengarah ke file yang benar

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Gunakan konfigurasi dari firebase_options.dart
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
  runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.black,
        ),
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
