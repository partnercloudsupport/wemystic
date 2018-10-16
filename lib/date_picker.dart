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
  FirebaseUser user;
  DateTime _date = new DateTime.now();
  String zodiacSign;
  String chineseSign;
  String chineseSignElement;
  String country;


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
      if (_date.month == 12) {
        if (_date.day < 22)
          zodiacSign = "Sagittarius";
        else
          zodiacSign = "Capricorn";
      } else if (_date.month == 01) {
        if (_date.day < 20)
          zodiacSign = "Capricorn";
        else
          zodiacSign = "Aquarius";
      } else if (_date.month == 02) {
        if (_date.day < 19)
          zodiacSign = "Aquarius";
        else
          zodiacSign = "Pisces";
      } else if (_date.month == 03) {
        if (_date.day < 21)
          zodiacSign = "Pisces";
        else
          zodiacSign = "Aries";
      } else if (_date.month == 04) {
        if (_date.day < 20)
          zodiacSign = "Aries";
        else
          zodiacSign = "Taurus";
      } else if (_date.month == 05) {
        if (_date.day < 21)
          zodiacSign = "Taurus";
        else
          zodiacSign = "Gemini";
      } else if (_date.month == 06) {
        if (_date.day < 21)
          zodiacSign = "Gemini";
        else
          zodiacSign = "Cancer";
      } else if (_date.month == 07) {
        if (_date.day < 23)
          zodiacSign = "Cancer";
        else
          zodiacSign = "Leo";
      } else if (_date.month == 08) {
        if (_date.day < 23)
          zodiacSign = "Leo";
        else
          zodiacSign = "Virgo";
      } else if (_date.month == 09) {
        if (_date.day < 23)
          zodiacSign = "Virgo";
        else
          zodiacSign ="Libra";
      } else if (_date.month == 10) {
        if (_date.day < 23)
          zodiacSign = "Libra";
        else
          zodiacSign = "Scorpio";
      } else if (_date.month == 11) {
        if (_date.day < 22)
          zodiacSign = "Scorpio";
        else
          zodiacSign = "Sagittarius";
      }
      if (_date.year == 2008 ||
          _date.year == 1996 ||
          _date.year == 1984 ||
          _date.year == 1972 ||
          _date.year == 1960) {

        chineseSign = "Rat";

      } else if (_date.year == 2009 ||
          _date.year == 1997 ||
          _date.year == 1985 ||
          _date.year == 1973 ||
          _date.year == 1961) {

        chineseSign = "Ox";

      } else if (_date.year == 2010 ||
          _date.year == 1998 ||
          _date.year == 1986 ||
          _date.year == 1974 ||
          _date.year == 1962) {

        chineseSign = "Tiger";

      } else if (_date.year == 2011 ||
          _date.year == 1999 ||
          _date.year == 1987 ||
          _date.year == 1975 ||
          _date.year == 1963 ) {

        chineseSign = "Rabbit";

      } else if (_date.year == 2012 ||
          _date.year == 2000 ||
          _date.year == 1988 ||
          _date.year == 1976 ||
          _date.year == 1954) {

        chineseSign = "Dragon";

      } else if (_date.year == 2013 ||
          _date.year == 2001 ||
          _date.year == 1989 ||
          _date.year == 1977 ||
          _date.year == 1965) {

        chineseSign = "Snake";

      } else if (_date.year == 2014 ||
          _date.year == 2002 ||
          _date.year == 1990 ||
          _date.year == 1978 ||
          _date.year == 1966) {

        chineseSign = "Horse";

      } else if (_date.year == 2015 ||
          _date.year == 2003 ||
          _date.year == 1991 ||
          _date.year == 1979 ||
          _date.year == 1967) {

        chineseSign = "Goat";

      } else if (_date.year == 2016 ||
          _date.year == 2004 ||
          _date.year == 1992 ||
          _date.year == 1980 ||
          _date.year == 1968) {

        chineseSign = "Monkey";

      } else if (_date.year == 2017 ||
          _date.year == 2005 ||
          _date.year == 1993 ||
          _date.year == 1981 ||
          _date.year == 1969) {

        chineseSign = "Rooster";

      } else if (_date.year == 2018 ||
          _date.year == 2006 ||
          _date.year == 1994 ||
          _date.year == 1982 ||
          _date.year == 1970) {

        chineseSign = "Dog";

      } else if (_date.year == 2019 ||
          _date.year == 2007 ||
          _date.year == 1995 ||
          _date.year == 1983 ||
          _date.year == 1971) {

        chineseSign = "Pig";

      }
      if (_date.year.toString().substring(3, 4) == '0' ||
          _date.year.toString().substring(3, 4) == '1') {

        chineseSignElement = "Metal";

      } else if (_date.year.toString().substring(3, 4) == '2' ||
          _date.year.toString().substring(3, 4) == '3') {

        chineseSignElement = "Water";

      } else if (_date.year.toString().substring(3, 4) == '4' ||
          _date.year.toString().substring(3, 4) == '5') {

        chineseSignElement = "Wood";

      } else if (_date.year.toString().substring(3, 4) == '6' ||
          _date.year.toString().substring(3, 4) == '7') {

        chineseSignElement = "Fire";

      } else if (_date.year.toString().substring(3, 4) == '8' ||
          _date.year.toString().substring(3, 4) == '9') {

        chineseSignElement = "Earth";

      }
    });
  }

  Future<Null> _favourites(BuildContext context) async{

  }


  _fireStoreAdd() async {
      FirebaseUser user =  await FirebaseAuth.instance.currentUser();
      final DocumentReference docRef = Firestore.instance.collection("profile").document("${user.uid.toString()}");
      Map<String, String> data = <String, String>{
        "birth_date" : _date.toString(),
        "zodiac_sign" : zodiacSign,
        "chinese_sign" : '$chineseSign $chineseSignElement',
        "pisces" : 'false',
        "aquarius" : 'false',
        "capricorn" : 'false',
        "sagittarius" : 'false',
        "scorpio" : 'false',
        "libra" : 'false',
        "virgo" : 'false',
        "leo" : 'false',
        "cancer" : 'false',
        "gemini" : 'false',
        "taurus" : 'false',
        "aries" : 'false',


      };
      docRef.setData(data).whenComplete(() {
        print("Document added");
      }).catchError((e) => print (e));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      padding: EdgeInsets.all(5.0),

      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('Date Selected: ${_date.toString()}',
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
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
    )
    );
  }
}


