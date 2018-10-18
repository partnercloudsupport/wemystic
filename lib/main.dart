import 'package:flutter/material.dart';
import 'package:wemystic/astrology/horoscope/pick_horoscope.dart';
import 'package:wemystic/login_page.dart';


void main() => runApp(new MyApp());



class MyApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new GridListDemo(),
    );
  }
}


