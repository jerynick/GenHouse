import "package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";
import 'package:firebase_auth/firebase_auth.dart';
import "package:firebase_database/firebase_database.dart";
import "package:gen_house/screens/genkey.dart";
import 'dashboard.dart';
import 'loginpage.dart';

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
    )
  );

  runApp(SettingsApp()); 
}

class SettingsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatefulWidget {
  
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  void _logout() async {
    await _auth.signOut();
    // Navigasi ke halaman login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 360,
          height: 800,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 373,
                  height: 149,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 11,
                        child: Container(
                          width: 360,
                          height: 138,
                          decoration: ShapeDecoration(
                            color: Color(0xFF164863),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17),
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
                        left: 53,
                        top: 62,
                        child: Container(
                          width: 320,
                          height: 53,
                          decoration: ShapeDecoration(
                            color: Color(0x549BBEC8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 44,
                        top: 58,
                        child: Container(
                          width: 329,
                          height: 53,
                          decoration: ShapeDecoration(
                            color: Color(0xFFDDF2FD),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 246,
                        top: 68,
                        child: SizedBox(
                          width: 108,
                          height: 33,
                          child: Text(
                            'Settings',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              height: 0,
                              decoration: TextDecoration.none
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 81,
                        top: 128,
                        child: Container(
                          width: 212,
                          height: 21,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => DashboardPage()),
                                    );
                                  },
                                child: SizedBox(
                                  width: 77,
                                  height: 21,
                                  child: Text(
                                    'Dashboard\n',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                      decoration: TextDecoration.none
                                    ),
                                  ),
                                ),
                                ),
                              ),
                              Positioned(
                                left: 152,
                                top: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => SettingsPage()),
                                    );
                                  },
                                child: SizedBox(
                                  width: 60,
                                  height: 21,
                                  child: Text(
                                    'Settings',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                      decoration: TextDecoration.none
                                    ),
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
                left: 27,
                top: 185,
                child: Container(
                  width: 306,
                  height: 102,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 306,
                          height: 102,
                          decoration: ShapeDecoration(
                            color: Color(0x549BBEC8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 12,
                        top: 8,
                        child: SizedBox(
                          width: 119,
                          height: 19,
                          child: Text(
                            'Genkey Setting',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              height: 0,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 12,
                        top: 30,
                        child: SizedBox(
                          width: 278,
                          height: 39,
                          child: Text(
                            'You can set your Genkey in this menu. Genkey is a “unique” name used to connect your application to your GenHouse IoT database. Submit for save the change, Discard for cancel',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 8,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              decoration: TextDecoration.none
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 273,
                        top: 79,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context) => GenkeyPage()),
                            );
                          },
                        child: SizedBox(
                          width: 24,
                          height: 23,
                          child: Text(
                            'Go',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              height: 0,
                              decoration: TextDecoration.none
                            ),
                          ),
                        ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 27,
                top: 298,
                child: Container(
                  width: 306,
                  height: 102,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 306,
                          height: 102,
                          decoration: ShapeDecoration(
                            color: Color(0xFF9D4242),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 12,
                        top: 8,
                        child: SizedBox(
                          width: 89,
                          height: 19,
                          child: Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              height: 0,
                              decoration: TextDecoration.none
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 12,
                        top: 27,
                        child: SizedBox(
                          width: 278,
                          height: 30,
                          child: Text(
                            'Are you sure to log out? Make sure to log in again to fully control your GenHouse device!',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              decoration: TextDecoration.none
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 275,
                        top: 79,
                        child: GestureDetector(
                          onTap: _logout,
                        child: SizedBox(
                          width: 24,
                          height: 23,
                          child: Text(
                            'Go',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              height: 0,
                              decoration: TextDecoration.none
                            ),
                          ),
                        ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 27,
                top: 666,
                child: Container(
                  width: 200,
                  height: 92,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/img/banner.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
