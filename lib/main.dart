import 'package:flutter/material.dart';
import 'package:wemystic/date_picker.dart';


void main() => runApp(new MyApp());

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new BornDate(),
    );
  }
}


