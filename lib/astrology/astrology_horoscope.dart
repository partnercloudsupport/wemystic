import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:intl/intl.dart';

class AstrologyHoroscope extends StatefulWidget {
  @override
  _AstrologyHoroscopeState createState() => _AstrologyHoroscopeState();
}

class _AstrologyHoroscopeState extends State<AstrologyHoroscope> {
  DateTime myText;
  String zodiacSign;

  _fireStoreFetch() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final DocumentReference docRef = Firestore.instance
        .collection("profile")
        .document("${user.uid.toString()}");
    docRef.get().then((dataSnapshot) {
      if (dataSnapshot.exists) {
        setState(() {
          myText = dataSnapshot.data['birth_date'];
          if (myText.month == 12) {
            if (myText.day < 22)
              zodiacSign = "Sagittarius";
            else
              zodiacSign = "capricorn";
          } else if (myText.month == 01) {
            if (myText.day < 20)
              zodiacSign = "Capricorn";
            else
              zodiacSign = "Aquarius";
          } else if (myText.month == 02) {
            if (myText.day < 19)
              zodiacSign = "Aquarius";
            else
              zodiacSign = "Pisces";
          } else if (myText.month == 03) {
            if (myText.day < 21)
              zodiacSign = "Pisces";
            else
              zodiacSign = "Aries";
          } else if (myText.month == 04) {
            if (myText.day < 20)
              zodiacSign = "Aries";
            else
              zodiacSign = "Taurus";
          } else if (myText.month == 05) {
            if (myText.day < 21)
              zodiacSign = "Taurus";
            else
              zodiacSign = "Gemini";
          } else if (myText.month == 06) {
            if (myText.day < 21)
              zodiacSign = "Gemini";
            else
              zodiacSign = "Cancer";
          } else if (myText.month == 07) {
            if (myText.day < 23)
              zodiacSign = "Cancer";
            else
              zodiacSign = "Leo";
          } else if (myText.month == 08) {
            if (myText.day < 23)
              zodiacSign = "Leo";
            else
              zodiacSign = "Virgo";
          } else if (myText.month == 09) {
            if (myText.day < 23)
              zodiacSign = "Virgo";
            else
              zodiacSign = "Libra";
          } else if (myText.month == 10) {
            if (myText.day < 23)
              zodiacSign = "Libra";
            else
              zodiacSign = "Scorpio";
          } else if (myText.month == 11) {
            if (myText.day < 22)
              zodiacSign = "Scorpio";
            else
              zodiacSign = "Sagittarius";
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Column(children: <Widget>[
        RaisedButton(
          onPressed: _fireStoreFetch,
          child: Text('Fetch'),
          color: Colors.lime,
        ),
        zodiacSign == null
            ? Container()
            : Text(
                zodiacSign,
              ),
      ]),
    ));
  }
}
