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
          if (myText.year == 2008 ||
              myText.year == 1996 ||
              myText.year == 1984 ||
              myText.year == 1972 ||
              myText.year == 1960) {

              zodiacSign = "Rat";

          } else if (myText.year == 2009 ||
              myText.year == 1997 ||
              myText.year == 1985 ||
              myText.year == 1973 ||
              myText.year == 1961) {

            zodiacSign = "Ox";

          } else if (myText.year == 2010 ||
              myText.year == 1998 ||
              myText.year == 1986 ||
              myText.year == 1974 ||
              myText.year == 1962) {

              zodiacSign = "Tiger";

          } else if (myText.year == 2011 ||
              myText.year == 1999 ||
              myText.year == 1987 ||
              myText.year == 1975 ||
              myText.year == 1963 ) {

              zodiacSign = "Rabbit";

          } else if (myText.year == 2012 ||
              myText.year == 2000 ||
              myText.year == 1988 ||
              myText.year == 1976 ||
              myText.year == 1954) {

              zodiacSign = "Dragon";

          } else if (myText.year == 2013 ||
              myText.year == 2001 ||
              myText.year == 1989 ||
              myText.year == 1977 ||
              myText.year == 1965) {

              zodiacSign = "Snake";

          } else if (myText.year == 2014 ||
              myText.year == 2002 ||
              myText.year == 1990 ||
              myText.year == 1978 ||
              myText.year == 1966) {

              zodiacSign = "Horse";

          } else if (myText.year == 2015 ||
              myText.year == 2003 ||
              myText.year == 1991 ||
              myText.year == 1979 ||
              myText.year == 1967) {

              zodiacSign = "Goat";

          } else if (myText.year == 2016 ||
              myText.year == 2004 ||
              myText.year == 1992 ||
              myText.year == 1980 ||
              myText.year == 1968) {

              zodiacSign = "Monkey";

          } else if (myText.year == 2017 ||
              myText.year == 2005 ||
              myText.year == 1993 ||
              myText.year == 1981 ||
              myText.year == 1969) {

              zodiacSign = "Rooster";

          } else if (myText.year == 2018 ||
              myText.year == 2006 ||
              myText.year == 1994 ||
              myText.year == 1982 ||
              myText.year == 1970) {

              zodiacSign = "Dog";

          } else if (myText.year == 2019 ||
              myText.year == 2007 ||
              myText.year == 1995 ||
              myText.year == 1983 ||
              myText.year == 1971) {

              zodiacSign = "Pig";
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