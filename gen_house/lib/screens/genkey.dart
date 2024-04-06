import "package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";
import "package:firebase_database/firebase_database.dart";
import "package:shared_preferences/shared_preferences.dart";
import 'dashboard.dart';
import 'settings.dart';

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

  runApp(GenkeyApp()); 
}

class GenkeyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GenkeyPage(),
    );
  }
}

class GenkeyPage extends StatefulWidget {
  
  @override
  _GenkeyPageState createState() => _GenkeyPageState();
}

class _GenkeyPageState extends State<GenkeyPage> {
  
  final TextEditingController _pathController = TextEditingController();
  String currentPath = '';

  @override 
  void initState() {
    super.initState();
    _getPreferences();
  }

  void _getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentPath = prefs.getString("firebase_path") ?? '/';
    setState(() {
      _pathController.text = currentPath;
    });
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
                        left: 158,
                        top: 68,
                        child: SizedBox(
                          width: 196,
                          height: 33,
                          child: Text(
                            'Genkey Setting',
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
                top: 666,
                child: Container(
                  width: 200,
                  height: 92,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/img/banner.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                top: 182,
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
                          width: 205,
                          height: 22,
                          child: Text(
                            'Genkey is Private. Carefull!!',
                            style: TextStyle(
                              color: Color(0xFFFF4747),
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
                                  width: 96,
                                  height: 16,
                                  child: Text(
                                    'Current Genkey',
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
                                  child: Text(
                                    '$currentPath',
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
                                    'New Genkey',
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
                                top: 26,
                                child: SizedBox(
                                  width: 290,
                                  height: 20,
                                  child: TextField(
                                    controller: _pathController,
                                    decoration: InputDecoration(
                                      hintText: '/uniquegenkey'
                                    ),
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
                      Positioned(
                        left: 19,
                        top: 167,
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
                                    _savePath();
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
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _savePath() async {
  String path = _pathController.text;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('firebase_path', path);
  
  }

  void _discardChange() {
    _pathController.clear();
  }
}