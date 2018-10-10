import 'package:flutter/material.dart';
import 'package:wemystic/bottom_nav_bar.dart';
import 'package:wemystic/date_picker.dart';
import 'package:wemystic/login_page.dart';
import 'package:wemystic/we_mystic_news.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

void main() => runApp(new MyApp());



class MyApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: new LoginPage(),
    );
  }
}


