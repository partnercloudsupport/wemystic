import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wemystic/bottom_nav_bar.dart';

class BornDate extends StatefulWidget {
  final FirebaseUser user;
  BornDate({this.user});


  @override
  _BornDateState createState() => _BornDateState();

}

class _BornDateState extends State<BornDate> {

  static FirebaseUser get currentUser => currentUser;


  final DocumentReference docRef = Firestore.instance.collection("profile").document("${currentUser.uid.toString()}");

  DateTime _date = new DateTime.now();



  Future<Null> _selectDate(BuildContext context) async{
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(1920),
        lastDate: DateTime.now());
    if (picked != null && picked != _date)
      print('Date Selected: ${_date.toString()}');
    setState(() {
      _date = picked;
    });
  }

  void _add() {
  Map<String, String> data = <String, String>{
    "birth_date" : _date.toString(),
  };
  docRef.setData(data).whenComplete(() {
    print("Document added");
  }).catchError((e) => print (e));
}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('Date Selected: ${_date.toString()}'),
            ],
          ),
          Row(
            children: <Widget>[
              RaisedButton(onPressed: () {
                _selectDate(context);
              },
                child: Text('Add Born Date'),
                color: Colors.red,),
            ],
          ),
          Row(
            children: <Widget>[
              RaisedButton(onPressed: () {
                _add();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => HomePage(
                      user: user,
                    )));
              },
                child: Text('Submit'),
                color: Colors.green,),
            ],
          )
        ],
      ),
    );
  }
}


