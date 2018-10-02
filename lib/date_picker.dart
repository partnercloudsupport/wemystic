import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wemystic/bottom_nav_bar.dart';
import 'package:intl/intl.dart';

main() {
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  String formatted = formatter.format(now);
  print(formatted); // something like 2013-04-20
}

class BornDate extends StatefulWidget {
  final FirebaseUser user;
  BornDate({this.user});


  @override
  _BornDateState createState() => _BornDateState();

}

class _BornDateState extends State<BornDate> {
  FirebaseUser user;

  DateTime _date = new DateTime.now().;



  _fireStoreAdd() async{
    FirebaseUser user =  await FirebaseAuth.instance.currentUser();
    final DocumentReference docRef = Firestore.instance.collection("profile").document("${user.uid.toString()}");
    Map<String, DateTime> data = <String, DateTime>{
      "birth_date" : _date,
    };
    docRef.setData(data).whenComplete(() {
      print("Document added");
    }).catchError((e) => print (e));
  }

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
                _fireStoreAdd();
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


