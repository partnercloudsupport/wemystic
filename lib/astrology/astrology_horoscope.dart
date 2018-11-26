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
  bool aquariusIsFav;
  bool ariesIsFav;
  bool cancerIsFav;
  bool capricornIsFav;
  bool geminiIsFav;
  bool leoIsFav;
  bool libraIsFav;
  bool piscesIsFav;
  bool scorpioIsFav;
  bool taurusIsFav;
  bool virgoIsFav;
  bool sagittariusIsFav;
  List<String> favorites = new List();
  String selectedIcon;
  String selectedIconName;
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
          aquariusIsFav = dataSnapshot.data['aquarius'];
          ariesIsFav = dataSnapshot.data['aries'];
          cancerIsFav = dataSnapshot.data['cancer'];
          capricornIsFav = dataSnapshot.data['capricorn'];
          geminiIsFav = dataSnapshot.data['gemini'];
          leoIsFav = dataSnapshot.data['leo'];
          libraIsFav = dataSnapshot.data['libra'];
          piscesIsFav = dataSnapshot.data['pisces'];
          sagittariusIsFav = dataSnapshot.data['sagittarius'];
          scorpioIsFav = dataSnapshot.data['scorpio'];
          taurusIsFav = dataSnapshot.data['taurus'];
          virgoIsFav = dataSnapshot.data['virgo'];
          if (aquariusIsFav == true) {
            favorites.add(
                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-aquario.png');
          }
          if (ariesIsFav == true) {
            favorites.add(
                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-aries.png');
          }
          if (cancerIsFav == true) {
            favorites.add(
                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-caranguejo.png');
          }
          if (capricornIsFav == true) {
            favorites.add(
                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-capricornio.png');
          }
          if (geminiIsFav == true) {
            favorites.add(
                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-gemeos.png');
          }
          if (leoIsFav == true) {
            favorites.add(
                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-leao.png');
          }
          if (libraIsFav == true) {
            favorites.add(
                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-libra.png');
          }
          if (piscesIsFav == true) {
            favorites.add(
                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-peixes.png');
          }
          if (sagittariusIsFav == true) {
            favorites.add(
                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-sagitario.png');
          }
          if (scorpioIsFav == true) {
            favorites.add(
                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-escorpiao.png');
          }
          if (taurusIsFav == true) {
            favorites.add(
                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-touro.png');
          }
          if (virgoIsFav == true) {
            favorites.add(
                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-virgem.png');
          }
        });
      }
    });
  }

  Widget horoscope;

  final List<String> _allActivities = <String>['Today', 'Week'];
  String _activity = 'Today';

  @override
  Widget build(BuildContext context) {
    if (selectedIcon == null) {
      return Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    children: favorites
                        .map((String src) => IconButton(
                              icon: Image.network(
                                src,
                              ),
                              onPressed: () {
                                setState(() {
                                  selectedIcon = src;
                                  if (selectedIcon ==
                                      'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-aquario.png') {
                                    selectedIconName = "Aquarius";
                                  } else if (selectedIcon ==
                                      'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-aries.png') {
                                    selectedIconName = "Aries";
                                  } else if (selectedIcon ==
                                      'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-caranguejo.png') {
                                    selectedIconName = "Cancer";
                                  } else if (selectedIcon ==
                                      'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-capricornio.png') {
                                    selectedIconName = "Capricorn";
                                  } else if (selectedIcon ==
                                      'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-gemeos.png') {
                                    selectedIconName = "Gemini";
                                  } else if (selectedIcon ==
                                      'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-leao.png') {
                                    selectedIconName = "Leo";
                                  } else if (selectedIcon ==
                                      'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-libra.png') {
                                    selectedIconName = "Libra";
                                  } else if (selectedIcon ==
                                      'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-peixes.png') {
                                    selectedIconName = "Pisces";
                                  } else if (selectedIcon ==
                                      'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-sagitario.png') {
                                    selectedIconName = "Sagittarius";
                                  } else if (selectedIcon ==
                                      'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-escorpiao.png') {
                                    selectedIconName = "Scorpio";
                                  } else if (selectedIcon ==
                                      'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-touro.png') {
                                    selectedIconName = "Taurus";
                                  } else if (selectedIcon ==
                                      'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-aries.png') {
                                    selectedIconName = "Aries";
                                  }

                                  _activity = 'Today';
                                });
                              },
                            ))
                        .toList(),
                  ),
                  Container(
                      child: Column(children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        myText == "Aquarius"
                            ? Image.network(
                                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-aquario.png')
                            : Container(),
                        myText == "Cancer"
                            ? Image.network(
                                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-aries.png')
                            : Container(),
                        myText == "Cancer"
                            ? Image.network(
                                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-caranguejo.png')
                            : Container(),
                        myText == "Capricorn"
                            ? Image.network(
                                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-capricornio.png',
                              )
                            : Container(),
                        myText == "Gemini"
                            ? Image.network(
                                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-gemeos.png')
                            : Container(),
                        myText == "Leo"
                            ? Image.network(
                                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-leao.png')
                            : Container(),
                        myText == "Libra"
                            ? Image.network(
                                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-libra.png')
                            : Container(),
                        myText == "Pisces"
                            ? Image.network(
                                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-peixes.png')
                            : Container(),
                        myText == "Sagittarius"
                            ? Image.network(
                                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-sagitario.png')
                            : Container(),
                        myText == "Scorpio"
                            ? Image.network(
                                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-escorpiao.png')
                            : Container(),
                        myText == "Taurus"
                            ? Image.network(
                                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-touro.png',
                              )
                            : Container(),
                        myText == "Aries"
                            ? Image.network(
                                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-aries.png')
                            : Container(),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(myText),
                      ],
                    ),
                  ])),
                ],
              ),
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
              _activity == 'Today'
                  ? TodayHoroscope(
                      value: myText,
                    )
                  : WeekHoroscope(),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    children: favorites
                        .map((String src) => IconButton(
                              icon: Image.network(
                                src,
                              ),
                              onPressed: () {
                                setState(() {
                                  selectedIcon = src;
                                });
                              },
                            ))
                        .toList(),
                  ),
                  Container(
                      child: Column(children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.network(selectedIcon),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        selectedIcon ==
                                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-aquario.png'
                            ? Text(selectedIconName = "Aquarius")
                            : Container(),
                        selectedIcon ==
                                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-aries.png'
                            ? Text(selectedIconName = "Aries")
                            : Container(),
                        selectedIcon ==
                                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-caranguejo.png'
                            ? Text(selectedIconName = "Cancer")
                            : Container(),
                        selectedIcon ==
                                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-capricornio.png'
                            ? Text(selectedIconName = "Capricorn")
                            : Container(),
                        selectedIcon ==
                                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-gemeos.png'
                            ? Text(selectedIconName = "Gemini")
                            : Container(),
                        selectedIcon ==
                                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-leao.png'
                            ? Text(selectedIconName = "Leo")
                            : Container(),
                        selectedIcon ==
                                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-libra.png'
                            ? Text(selectedIconName = "Libra")
                            : Container(),
                        selectedIcon ==
                                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-peixes.png'
                            ? Text(selectedIconName = "Pisces")
                            : Container(),
                        selectedIcon ==
                                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-sagitario.png'
                            ? Text(selectedIconName = "Sagittarius")
                            : Container(),
                        selectedIcon ==
                                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-escorpiao.png'
                            ? Text(selectedIconName = "Scorpio")
                            : Container(),
                        selectedIcon ==
                                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-touro.png'
                            ? Text(selectedIconName = "Taurus")
                            : Container(),
                        selectedIcon ==
                                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-aries.png'
                            ? Text(selectedIconName = "Aries")
                            : Container(),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(children: <Widget>[
                          RaisedButton(
                            child: Text('Today'),
                            onPressed: null,
                          )
                        ]),
                        Column(
                          children: <Widget>[
                            RaisedButton(
                              child: Text('Week'),
                              onPressed: null,
                            )
                          ],
                        )
                      ],
                    )
                  ])),
                ],
              ),
              _activity == 'Today'
                  ? TodayHoroscope(
                      value: selectedIconName,
                    )
                  : WeekHoroscope(),
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
