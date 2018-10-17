import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wemystic/astrology/horoscope/pick_horoscope.dart';
import 'package:wemystic/login_page.dart';


void main() => runApp(new MyApp());



class MyApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new GridPhotoViewer(),
    );
  }
}


