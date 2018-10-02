import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class AstrologyHoroscope extends StatefulWidget{
  @override
  _AstrologyHoroscopeState createState() => _AstrologyHoroscopeState();
}

class _AstrologyHoroscopeState extends State<AstrologyHoroscope>{
  String myText;

  _fireStoreFetch() async{
    FirebaseUser user =  await FirebaseAuth.instance.currentUser();
    final DocumentReference docRef = Firestore.instance.collection("profile").document("${user.uid.toString()}");
    docRef.get().then((dataSnapshot){
      if(dataSnapshot.exists){
        setState(() {
          myText =dataSnapshot.data['birth_date'];
        });
      }
    });
  }


  Widget _buildChild() {
    if (myText == '20-05') {
      return Text('Your sign is: Taurus');
    }else
      return Text('your sign is merda nenhuma');
  }


    @override
    Widget build(BuildContext context) {
      return Container(
        child: Center(
          child: _buildChild(),
        ),
      );
    }
}







