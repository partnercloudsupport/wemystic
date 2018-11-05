import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wemystic/astrology/horoscope/today_horoscope.dart';
import 'package:wemystic/astrology/horoscope/week_horoscope.dart';
import 'package:wemystic/astrology/favorite_signs.dart';

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

  Widget horoscope;

  _horoscope(){
    if (_activity == 'Today') {
      horoscope = TodayHoroscope(value: myText);
    } else if (_activity == 'Week') {
      horoscope = WeekHoroscope();
    } else {
      horoscope = Container(
          child: Text("lalalalalal")
      );
    }
  }

  final List<String> _allActivities = <String>['Today', 'Week'];
  String _activity = 'Today';



  @override
  Widget build(BuildContext context) {
    if (myText == null) {
      return new Container();
    } else {
      return Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              ImageCarousel(),
              InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Activity',
                  hintText: 'Choose an activity',
                  contentPadding: EdgeInsets.zero,
                ),
                isEmpty: _activity == null,
                child: DropdownButton<String>(
                  value: _activity,
                  onChanged: (String newValue) {
                    setState(() {
                      _activity = newValue;
                      _horoscope();

                    });
                  },
                  items: _allActivities
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Container(child: Text("today"),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    this._horoscope();
    this._fireStoreFetch();
  }
}
