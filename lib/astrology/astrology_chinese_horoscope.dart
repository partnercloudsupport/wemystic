import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class AstrologyChineseHoroscope extends StatefulWidget{
  @override
  _AstrologyChineseHoroscopeState createState() => _AstrologyChineseHoroscopeState();


}

class _AstrologyChineseHoroscopeState extends State<AstrologyChineseHoroscope>{
  String myText;
  Widget chineseSign;

  _fireStoreFetch() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final DocumentReference docRef = Firestore.instance
        .collection("profile")
        .document("${user.uid.toString()}");
    docRef.get().then((dataSnapshot) {
      if (dataSnapshot.exists) {
        setState(() {
          myText = dataSnapshot.data['chinese_sign'];
          chineseSign = Text(myText);
        });
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._fireStoreFetch();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
          child: Column(children: <Widget>[
              myText == null
            ?Container()
                  : chineseSign
          ]),
        ));
  }

}