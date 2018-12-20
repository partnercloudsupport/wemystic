import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wemystic/date_picker.dart';
import 'package:wemystic/login_page.dart';
import 'package:wemystic/pick_horoscope.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
        onLaunch: (Map<String, dynamic> msg) {
          print("called");
        },
        onResume: (Map<String, dynamic> msg) {
          print("called");
        },
        onMessage: (Map<String, dynamic> msg) {
          print("called");
        }
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
          sound: true,
          alert: true,
          badge: true,

        )
    );
    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings){
      print('IOS setting registered');
    });
    _firebaseMessaging.getToken().then((token){
      update(token);
    });
  }

  update(String token){
    print(token);

  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new LoginPage(),
    );
  }
}


