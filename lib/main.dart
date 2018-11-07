import 'package:flutter/material.dart';
import 'package:wemystic/login_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


void main() => runApp(new MyApp());

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic> msg) {
        print("called");
    },
      onResume: (Map<String, dynamic> msg) {
        print("called");
      },
      onMessage: (Map<String, dynamic> msg) {
        print("called");
      },
    );
    firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
        sound:true,
        alert:true,
        badge:true,
      )
    );
    firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings){
      print('Ios Setting Registed');
    });
    firebaseMessaging.getToken().then((token){
      update(token);
    });
  }

  update(String token){
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new LoginPage(),
    );
  }
}


