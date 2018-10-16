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
    if (myText == null) {
      return new Container();
    } else {
      return Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              Text(myText),
              Expanded(
                  child: TodayHoroscope(value: myText)),
            ],
          ),
        ),
      );
    }

  }

  @override
  void initState() {
    super.initState();

    this._fireStoreFetch();
  }
}
