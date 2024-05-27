import "package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";
import "package:firebase_database/firebase_database.dart";
import "package:gen_house/settings/settings.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart";

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

  runApp(DashboardApp());
}

class DashboardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  
  @override
  _DashboardPageState createState() => _DashboardPageState();
}


class _DashboardPageState extends State<DashboardPage> {

  String daycycle = 'N/A';
  String imageUrl = 'assets/img/defaultday.png';
  String imageAlarm = 'assets/icon/defaultfire.png';
  String imageDoor = 'assets/img/defaultdoor.png';
  String door = 'N/A';
  String fire = 'N/A';
  String controlMode = '';

  double temp = 0.0;
  double hum = 0.0;

  bool isLed1On = true;
  bool isLed2On = true;
  bool isFanOn = true;
  bool isDoorLocked = true;
  bool isGateOpen = true;

  late DatabaseReference MonitorRef;
  late DatabaseReference Led1Reference;
  late DatabaseReference Led2Reference;
  late DatabaseReference FanReference;
  late DatabaseReference DoorReference;
  late DatabaseReference GateReference;
  late DatabaseReference modeRef;
  
  @override
  void initState(){
    super.initState();
    _getDataFirebase();
    _getControlMode();
  }

  void _getControlMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String path = prefs.getString('firebase_path') ?? '/';
    modeRef = FirebaseDatabase.instance.reference().child('$path/mode');
    modeRef.onValue.listen((event) {
      setState(() {
        controlMode = event.snapshot.value.toString();
      });
    });
  }

  void _autoControlLogic() {
    if (temp > 35.0) {
      FanReference.set('ON');
    } else {
      FanReference.set('OFF');
    }
    if (daycycle == 'DARK') {
      Led1Reference.set('ON');
      Led2Reference.set('ON');
    } else {
      Led1Reference.set('OFF');
      Led2Reference.set('OFF');
    }
  }

  void _getDataFirebase() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String path = prefs.getString('firebase_path') ?? '/';
    
    MonitorRef = FirebaseDatabase.instance.reference().child('$path');
    Led1Reference = FirebaseDatabase.instance.reference().child('$path/led1');
    Led2Reference = FirebaseDatabase.instance.reference().child('$path/led2');
    FanReference = FirebaseDatabase.instance.reference().child('$path/fan');
    DoorReference = FirebaseDatabase.instance.reference().child('$path/doorlock');
    GateReference = FirebaseDatabase.instance.reference().child('$path/gate');
    MonitorRef.onValue.listen((event) {
      try {
        if (event.snapshot.value !=null) {
          final dynamic data = event.snapshot.value;
          setState(() {
            daycycle = (data['day'] as String?) ?? '';
            temp = (data['suhu'] as double?) ?? 0.0;
            hum = (data['kelembaban'] as double?) ?? 0.0;
            door = (data['door'] as String?) ?? '';
            fire = (data['fire'] as String?) ?? '';
          });
          updateImage();
          updateAlarm();
          updateDoor();
          if (controlMode == 'auto') {
            _autoControlLogic();
          }
        }
      } catch (e) {
        print('Error: $e');
      }
    });
  
    Led1Reference.onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          isLed1On = event.snapshot.value == 'ON';
        });
      }
    });

    Led2Reference.onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          isLed2On = event.snapshot.value == 'ON';
        });
      }
    });

    FanReference.onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          isFanOn = event.snapshot.value == 'ON';
        });
      }
    });

    GateReference.onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          isGateOpen = event.snapshot.value == 'OPEN';
        });
      }
    });

    DoorReference.onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          isDoorLocked = event.snapshot.value == 'LOCK';
        });
      }
    });
  }

  void _toggleLed1() {
    if (controlMode == 'manual') {
    setState(() {
      isLed1On = !isLed1On;
    });

    Led1Reference.set(isLed1On ? 'ON' : 'OFF');
    } else {
      print("Hohoho");
    }
  }

  void _toggleLed2() {

    setState(() {
      isLed2On = !isLed2On;
    });

    Led2Reference.set(isLed2On ? 'ON' : 'OFF');
  }

  void _toggleFan() {
    setState(() {
      isFanOn = !isFanOn;
    });

    FanReference.set(isFanOn ? 'ON' : 'OFF');
  }

  void _toggleDoor() {
    setState(() {
      isDoorLocked = !isDoorLocked;
    });

    DoorReference.set(isDoorLocked ? 'LOCK' : 'UNLOCK');
  }

  void _toggleGate() {
    setState(() {
      isGateOpen = !isGateOpen;
    });

    GateReference.set(isGateOpen ? 'OPEN' : 'CLOSE');
  }

  void updateImage() {
    setState(() {
      if (daycycle == 'BRIGHT') {
        imageUrl = 'assets/img/bright.png';
      } else if (daycycle == 'DARK') {
        imageUrl = 'assets/img/dark.png';
      } else {
        imageUrl = 'assets/img/defaultday.png';
      }
    });
  }

  void updateAlarm() {
    setState(() {
      if (fire == 'DETECTED') {
        imageAlarm = 'assets/icon/detected.png';
      } else if (fire == 'UNDETECTED') {
        imageAlarm = 'assets/icon/undetected.png';
      } else {
        imageAlarm = 'assets/icon/defaultfire.png';
      }
    });
  }

  void updateDoor() {
    setState(() {
      if (door == 'OPEN') {
        imageDoor = 'assets/img/open.png';
      } else if (door == 'CLOSE') {
        imageDoor = 'assets/img/close.png';
      } else {
        imageDoor = 'assets/img/defaultdoor.png';
      }
    });
  }

  _emergency() async {
    const number = '911';
    bool res = await FlutterPhoneDirectCaller.callNumber(number) ?? false;
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
                        left: 235,
                        top: 68,
                        child: SizedBox(
                          width: 122,
                          height: 33,
                          child: Text(
                            'Dashboard',
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
                left: 17,
                top: 182,
                child: Container(
                  width: 327,
                  height: 129,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 327,
                          height: 129,
                          decoration: ShapeDecoration(
                            color: Color(0x7FD5D7D7),
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
                          width: 327,
                          height: 123,
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
                          width: 327,
                          height: 123,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: AssetImage(imageUrl),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 17,
                top: 323,
                child: Container(
                  width: 327,
                  height: 178,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 327,
                          height: 178,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 9,
                                top: 0,
                                child: Container(
                                  width: 310,
                                  height: 178,
                                  decoration: ShapeDecoration(
                                    color: Color(0x7F9BBEC8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(17),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 6,
                                child: Container(
                                  width: 327,
                                  height: 166,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF164863),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(17),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 23,
                                top: 17,
                                child: SizedBox(
                                  width: 162,
                                  child: Text(
                                    'GenHouse Monitor',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
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
                        left: 9,
                        top: 45,
                        child: Container(
                          width: 100,
                          height: 53,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 100,
                                  height: 53,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF427D9D),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    shadows: [
                                      BoxShadow(
                                        color: Color(0x3F000000),
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 17.14,
                                top: 5,
                                child: SizedBox(
                                  width: 65.71,
                                  height: 15,
                                  child: Text(
                                    'Temperature',
                                    textAlign: TextAlign.center,
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
                                left: 27,
                                top: 23,
                                child: Container(
                                  width: 50,
                                  height: 23,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Text(
                                          '$temp',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                            height: 0,
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 31,
                                        top: 0,
                                        child: Text(
                                          '°C',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                            height: 0,
                                            decoration: TextDecoration.none,
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
                        left: 9,
                        top: 109,
                        child: Container(
                          width: 100,
                          height: 50,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 100,
                                  height: 50,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF427D9D),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    shadows: [
                                      BoxShadow(
                                        color: Color(0x3F000000),
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 17,
                                top: 5,
                                child: SizedBox(
                                  width: 65.71,
                                  height: 14.15,
                                  child: Text(
                                    'Humidity',
                                    textAlign: TextAlign.center,
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
                                left: 27,
                                top: 25,
                                child: Container(
                                  width: 45,
                                  height: 23,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Text(
                                          '$hum',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                            height: 0,
                                            decoration: TextDecoration.none
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 31,
                                        top: 0,
                                        child: Text(
                                          '%',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                            height: 0,
                                            decoration: TextDecoration.none
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
                        left: 124,
                        top: 77,
                        child: Container(
                          width: 100,
                          height: 53,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 100,
                                  height: 53,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF427D9D),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    shadows: [
                                      BoxShadow(
                                        color: Color(0x3F000000),
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 17.14,
                                top: 5,
                                child: SizedBox(
                                  width: 65.71,
                                  height: 15,
                                  child: Text(
                                    'Door',
                                    textAlign: TextAlign.center,
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
                                left: 25,
                                top: 27,
                                child: Container(
                                  width: 50,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(imageDoor),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 238,
                        top: 45,
                        child: Container(
                          width: 75,
                          height: 95,
                          child: GestureDetector (
                            onTap: _emergency,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 77,
                                child: Container(
                                  width: 75,
                                  height: 18,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFFF0000),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 6,
                                top: 79,
                                child: SizedBox(
                                  width: 62,
                                  height: 14,
                                  child: Text(
                                    'Emergency',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF080808),
                                      fontSize: 10,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                      decoration: TextDecoration.none
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 1,
                                top: 0,
                                child: Container(
                                  width: 72,
                                  height: 72,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(imageAlarm),
                                      fit: BoxFit.fill,
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
                left: 17,
                top: 518,
                child: Container(
                  width: 327,
                  height: 272,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 9,
                        top: 0,
                        child: Container(
                          width: 310,
                          height: 272,
                          decoration: ShapeDecoration(
                            color: Color(0x7F9BBEC8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 7,
                        child: Container(
                          width: 327,
                          height: 258,
                          decoration: ShapeDecoration(
                            color: Color(0xFF164863),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 23,
                        top: 22,
                        child: SizedBox(
                          width: 160,
                          child: Text(
                            'GenHouse Control',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              height: 0,
                              decoration: TextDecoration.none
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 17,
                        top: 62,
                        child: Container(
                          width: 283,
                          height: 192,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: GestureDetector (
                                  onDoubleTap: _toggleLed1,
                                child: Container(
                                  width: 75,
                                  height: 91,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 75,
                                          height: 75,
                                          decoration: ShapeDecoration(
                                            color: Color(0xFF427D9D),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            shadows: [
                                              BoxShadow(
                                                color: Color(0x3F000000),
                                                blurRadius: 4,
                                                offset: Offset(0, 4),
                                                spreadRadius: 0,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 13,
                                        top: 13,
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(isLed1On ? 'assets/icon/led_on.png' : 'assets/icon/led_off.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 11,
                                        top: 79,
                                        child: Text(
                                          'Bedroom Lamp',
                                          textAlign: TextAlign.center,
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
                                    ],
                                  ),
                                ),
                                ),
                              ),
                              Positioned(
                                left: 106,
                                top: 0,
                                child: GestureDetector (
                                  onDoubleTap: _toggleLed2,
                                child: Container(
                                  width: 75,
                                  height: 91,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 75,
                                          height: 75,
                                          decoration: ShapeDecoration(
                                            color: Color(0xFF427D9D),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            shadows: [
                                              BoxShadow(
                                                color: Color(0x3F000000),
                                                blurRadius: 4,
                                                offset: Offset(0, 4),
                                                spreadRadius: 0,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 13,
                                        top: 13,
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(isLed2On ? 'assets/icon/led_on.png' : 'assets/icon/led_off.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 23,
                                        top: 79,
                                        child: Text(
                                          'Hall Lamp',
                                          textAlign: TextAlign.center,
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
                                    ],
                                  ),
                                ),
                                ),
                              ),
                              Positioned(
                                left: 208,
                                top: 0,
                                child: GestureDetector (
                                  onDoubleTap: _toggleFan,
                                child: Container(
                                  width: 75,
                                  height: 91,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 75,
                                          height: 75,
                                          decoration: ShapeDecoration(
                                            color: Color(0xFF427D9D),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            shadows: [
                                              BoxShadow(
                                                color: Color(0x3F000000),
                                                blurRadius: 4,
                                                offset: Offset(0, 4),
                                                spreadRadius: 0,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 13,
                                        top: 13,
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(isFanOn ? 'assets/icon/fan_on.png' : 'assets/icon/fan_off.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 19,
                                        top: 79,
                                        child: Text(
                                          'Fan Control',
                                          textAlign: TextAlign.center,
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
                                    ],
                                  ),
                                ),
                                ),
                              ),
                              Positioned(
                                left: 46,
                                top: 101,
                                child: GestureDetector (
                                  onDoubleTap: _toggleDoor,
                                child: Container(
                                  width: 75,
                                  height: 91,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 75,
                                          height: 75,
                                          decoration: ShapeDecoration(
                                            color: Color(0xFF427D9D),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            shadows: [
                                              BoxShadow(
                                                color: Color(0x3F000000),
                                                blurRadius: 4,
                                                offset: Offset(0, 4),
                                                spreadRadius: 0,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 13,
                                        top: 13,
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(isDoorLocked ? 'assets/icon/door_lock.png' : 'assets/icon/door_unlock.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 9,
                                        top: 79,
                                        child: Text(
                                          'Doorlock Control',
                                          textAlign: TextAlign.center,
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
                                    ],
                                  ),
                                ),
                                ),
                              ),
                              Positioned(
                                left: 162,
                                top: 101,
                                child: GestureDetector (
                                  onDoubleTap: _toggleGate,
                                child: Container(
                                  width: 75,
                                  height: 91,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 75,
                                          height: 75,
                                          decoration: ShapeDecoration(
                                            color: Color(0xFF427D9D),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            shadows: [
                                              BoxShadow(
                                                color: Color(0x3F000000),
                                                blurRadius: 4,
                                                offset: Offset(0, 4),
                                                spreadRadius: 0,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 13,
                                        top: 13,
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(isGateOpen ? 'assets/icon/gate_opened.png' : 'assets/icon/gate_closed.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 16,
                                        top: 79,
                                        child: Text(
                                          'Gate Control',
                                          textAlign: TextAlign.center,
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
                                    ],
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
            ],
          ),
        ),
      ],
    );
  }
}

