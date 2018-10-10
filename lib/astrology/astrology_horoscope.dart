import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wemystic/astrology/horoscope/today_horoscope.dart';


class AstrologyHoroscope extends StatefulWidget {
  @override
  _AstrologyHoroscopeState createState() => _AstrologyHoroscopeState();
}

class _AstrologyHoroscopeState extends State<AstrologyHoroscope> {
  String myText;
  var list;
  var random;

  final String url =
      "https://api.rss2json.com/v1/api.json?rss_url=https://www.wemystic.com/feed";
  List data;

  Future<String> getTodayHoroscope() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      var resBody = json.decode(res.body);
      data = resBody["items"];
    });

    return "Success!";
  }

  _fireStoreFetch() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final DocumentReference docRef = Firestore.instance
        .collection("profile")
        .document("${user.uid.toString()}");
    docRef.get().then((dataSnapshot) {
      if (dataSnapshot.exists) {
        setState(() {
          myText = dataSnapshot.data['zodiac_sign'];
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Column(children: <Widget>[
            RaisedButton(onPressed: _fireStoreFetch,
            child: Text('Fetch'),

            ),
            myText == null
                ? Container()
                : Text(myText),
              TodayHoroscope(),



    ])));
  }
  @override
  void initState() {
    super.initState();
    this.getTodayHoroscope();
  }
}
