import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wemystic/astrology/horoscope/today_horoscope.dart';
import 'package:wemystic/astrology/horoscope/week_horoscope.dart';

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
            favorites.add('images/zodiac/icon_zodiac_white_aquarius.png');
          }
          if (ariesIsFav == true) {
            favorites.add('images/zodiac/icon_zodiac_white_aries.png');
          }
          if (cancerIsFav == true) {
            favorites.add('images/zodiac/icon_zodiac_white_cancer.png');
          }
          if (capricornIsFav == true) {
            favorites.add('images/zodiac/icon_zodiac_white_capricorn.png');
          }
          if (geminiIsFav == true) {
            favorites.add('images/zodiac/icon_zodiac_white_gemini.png');
          }
          if (leoIsFav == true) {
            favorites.add('images/zodiac/icon_zodiac_white_leo.png');
          }
          if (libraIsFav == true) {
            favorites.add('images/zodiac/icon_zodiac_white_libra.png');
          }
          if (piscesIsFav == true) {
            favorites.add('images/zodiac/icon_zodiac_white_pisces.png');
          }
          if (sagittariusIsFav == true) {
            favorites.add('images/zodiac/icon_zodiac_white_sagittarius.png');
          }
          if (scorpioIsFav == true) {
            favorites.add('images/zodiac/icon_zodiac_white_scorpio.png');
          }
          if (taurusIsFav == true) {
            favorites.add('images/zodiac/icon_zodiac_white_taurus.png');
          }
          if (virgoIsFav == true) {
            favorites.add('images/zodiac/icon_zodiac_white_virgo.png');
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
          appBar: AppBar(
            actions: <Widget>[
              FlatButton(
                  onPressed: null,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text('HOROSCOPE CHINO'),
                      Icon(
                        Icons.chevron_right,
                      )
                    ],
                  ))
            ],
            backgroundColor: Color.fromRGBO(56, 107, 169, 1.0),
            elevation: 0.0,
            automaticallyImplyLeading: false,
          ),
          body: Column(children: <Widget>[
            new Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    // 10% of the width, so there are ten blinds.
                    colors: [
                      const Color.fromRGBO(56, 107, 169, 1.0),
                      const Color.fromRGBO(111, 108, 160, 1.0)
                    ],
                    // whitish to gray
                    tileMode: TileMode
                        .repeated, // repeats the gradient over the canvas
                  ),
                ),
                child: Column(
                  children: <Widget>[
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
                    Row(
                      children: favorites
                          .map((String src) => IconButton(
                        icon: Image(image: AssetImage(
                          src,)
                        ),
                        onPressed: () {
                          setState(() {
                            selectedIcon = src;
                            if (selectedIcon ==
                                'images/zodiac/icon_zodiac_white_aquarius.png') {
                              selectedIconName = "Aquarius";
                            } else if (selectedIcon ==
                                'images/zodiac/icon_zodiac_white_aries.png') {
                              selectedIconName = "Aries";
                            } else if (selectedIcon ==
                                'images/zodiac/icon_zodiac_white_cancer.png') {
                              selectedIconName = "Cancer";
                            } else if (selectedIcon ==
                                'images/zodiac/icon_zodiac_white_capricorn.png') {
                              selectedIconName = "Capricorn";
                            } else if (selectedIcon ==
                                'images/zodiac/icon_zodiac_white_gemini.png') {
                              selectedIconName = "Gemini";
                            } else if (selectedIcon ==
                                'images/zodiac/icon_zodiac_white_leo.png') {
                              selectedIconName = "Leo";
                            } else if (selectedIcon ==
                                'images/zodiac/icon_zodiac_white_libra.png') {
                              selectedIconName = "Libra";
                            } else if (selectedIcon ==
                                'images/zodiac/icon_zodiac_white_pisces.png') {
                              selectedIconName = "Pisces";
                            } else if (selectedIcon ==
                                'images/zodiac/icon_zodiac_white_sagittarius.png') {
                              selectedIconName = "Sagittarius";
                            } else if (selectedIcon ==
                                'images/zodiac/icon_zodiac_white_scorpio.png') {
                              selectedIconName = "Scorpio";
                            } else if (selectedIcon ==
                                'images/zodiac/icon_zodiac_white_taurus.png') {
                              selectedIconName = "Taurus";
                            } else if (selectedIcon ==
                                'images/zodiac/icon_zodiac_white_virgo.png') {
                              selectedIconName = "Virgo";
                            }

                            _activity = 'Today';
                          });
                        },
                      ))
                          .toList(),
                    ),
                  ],
                ))
          ]));
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("WeMystic News"),
          backgroundColor: Color.fromRGBO(56, 107, 169, 1.0),
          elevation: 0.0,
          automaticallyImplyLeading: false,
        ),
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
                  ])),
                ],
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
    this._fireStoreFetch();
  }
}
