import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wemystic/astrology/horoscope.dart';

class AstrologyHoroscope extends StatefulWidget {
  @override
  _AstrologyHoroscopeState createState() => _AstrologyHoroscopeState();
}

class _AstrologyHoroscopeState extends State<AstrologyHoroscope> {
  Color notPressedButtonTextColor = Color.fromRGBO(187, 188, 189, 1.0);
  Color notPressedButtonColor;
  Color pressedButtonColor = Color.fromRGBO(170, 103, 167, 1.0);
  Color pressedButtonTextColor = Colors.white;
  bool _loadingInProgress;
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
  String selectedIconImage;
  Widget horoscope = Horoscope();

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


  @override
  Widget build(BuildContext context) {
    if (_loadingInProgress) {
      return new Container(
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
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
          ),
        ),
        child: Container(
          alignment: Alignment(0.0, 0.0),
          child: Image(image: AssetImage('images/loading_icon.png')),
        ),
      );
    } else if (selectedIcon == null) {
      return Scaffold(
          appBar: AppBar(
            title: Text(
              'Horoscope',
              style: TextStyle(fontFamily: 'Dosis', fontSize: 20.0),
            ),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      myText == "Aquarius"
                          ? Container(
                              width: 100.0,
                              height: 100.0,
                              child: Image(
                                image: AssetImage(
                                    'images/i_zodiac/i_aquarius.png'),
                                fit: BoxFit.fill,
                                filterQuality: FilterQuality.high,
                              ))
                          : Container(),
                      myText == "Aries"
                          ? Image(
                              image: AssetImage('images/i_zodiac/i_aries.png'))
                          : Container(),
                      myText == "Cancer"
                          ? Image(
                              image: AssetImage('images/i_zodiac/i_cancer.png'))
                          : Container(),
                      myText == "Capricorn"
                          ? Image(
                              image:
                                  AssetImage('images/i_zodiac/i_capricorn.png'))
                          : Container(),
                      myText == "Gemini"
                          ? Image(
                              image: AssetImage('images/i_zodiac/i_gemini.png'))
                          : Container(),
                      myText == "Leo"
                          ? Image(
                              image: AssetImage('images/i_zodiac/i_leo.png'))
                          : Container(),
                      myText == "Libra"
                          ? Image(
                              image: AssetImage('images/i_zodiac/i_libra.png'))
                          : Container(),
                      myText == "Pisces"
                          ? Image(
                              image: AssetImage('images/i_zodiac/i_pisces.png'))
                          : Container(),
                      myText == "Sagittarius"
                          ? Image(
                              image: AssetImage(
                                  'images/i_zodiac/i_sagittarius.png'))
                          : Container(),
                      myText == "Scorpio"
                          ? Image(
                              image:
                                  AssetImage('images/i_zodiac/i_scorpio.png'))
                          : Container(),
                      myText == "Taurus"
                          ? Image(
                              image: AssetImage('images/i_zodiac/i_taurus.png'))
                          : Container(),
                      myText == "Virgo"
                          ? Image(
                              image: AssetImage('images/i_zodiac/i_virgo.png'))
                          : Container(),
                      Padding(
                        child: Text(
                          myText.toUpperCase(),
                          style: TextStyle(
                            fontFamily: 'Dosis',
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      ),
                      new Container(
                        height: 80.0,
                        child: new ListView(
                          scrollDirection: Axis.horizontal,
                          children: favorites
                              .map((String src) => Container(
                                      child: IconButton(
                                    iconSize: 44.0,
                                    icon: Image(
                                        image: AssetImage(
                                      src,
                                    )),
                                    onPressed: () {
                                      setState(() {
                                        selectedIcon = src;
                                        if (selectedIcon ==
                                            'images/zodiac/icon_zodiac_white_aquarius.png') {
                                          selectedIconName = "Aquarius";
                                          selectedIconImage =
                                              'images/i_zodiac/i_aquarius.png';
                                        } else if (selectedIcon ==
                                            'images/zodiac/icon_zodiac_white_aries.png') {
                                          selectedIconName = "Aries";
                                          selectedIconImage =
                                              'images/i_zodiac/i_aries.png';
                                        } else if (selectedIcon ==
                                            'images/zodiac/icon_zodiac_white_cancer.png') {
                                          selectedIconName = "Cancer";
                                          selectedIconImage =
                                              'images/i_zodiac/i_cancer.png';
                                        } else if (selectedIcon ==
                                            'images/zodiac/icon_zodiac_white_capricorn.png') {
                                          selectedIconName = "Capricorn";
                                          selectedIconImage =
                                              'images/i_zodiac/i_capricorn.png';
                                        } else if (selectedIcon ==
                                            'images/zodiac/icon_zodiac_white_gemini.png') {
                                          selectedIconName = "Gemini";
                                          selectedIconImage =
                                              'images/i_zodiac/i_gemini.png';
                                        } else if (selectedIcon ==
                                            'images/zodiac/icon_zodiac_white_leo.png') {
                                          selectedIconName = "Leo";
                                          selectedIconImage =
                                              'images/i_zodiac/i_leo.png';
                                        } else if (selectedIcon ==
                                            'images/zodiac/icon_zodiac_white_libra.png') {
                                          selectedIconName = "Libra";
                                          selectedIconImage =
                                              'images/i_zodiac/i_libra.png';
                                        } else if (selectedIcon ==
                                            'images/zodiac/icon_zodiac_white_pisces.png') {
                                          selectedIconName = "Pisces";
                                          selectedIconImage =
                                              'images/i_zodiac/i_pisces.png';
                                        } else if (selectedIcon ==
                                            'images/zodiac/icon_zodiac_white_sagittarius.png') {
                                          selectedIconName = "Sagittarius";
                                          selectedIconImage =
                                              'images/i_zodiac/i_sagittarius.png';
                                        } else if (selectedIcon ==
                                            'images/zodiac/icon_zodiac_white_scorpio.png') {
                                          selectedIconName = "Scorpio";
                                          selectedIconImage =
                                              'images/i_zodiac/i_scorpio.png';
                                        } else if (selectedIcon ==
                                            'images/zodiac/icon_zodiac_white_taurus.png') {
                                          selectedIconName = "Taurus";
                                          selectedIconImage =
                                              'images/i_zodiac/i_taurus.png';
                                        } else if (selectedIcon ==
                                            'images/zodiac/icon_zodiac_white_virgo.png') {
                                          selectedIconName = "Virgo";
                                          selectedIconImage =
                                              'images/i_zodiac/i_virgo.png';
                                        }
                                      });
                                    },
                                  )))
                              .toList(),
                        ),
                      )
                    ])),
            Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          notPressedButtonTextColor =
                              Color.fromRGBO(187, 188, 189, 1.0);
                          notPressedButtonColor = null;
                          pressedButtonColor =
                              Color.fromRGBO(170, 103, 167, 1.0);
                          pressedButtonTextColor = Colors.white;
                        });
                      },
                      color: pressedButtonColor,
                      child: Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Padding(
                            child: Text(
                              'TODAY',
                              style: TextStyle(
                                  fontSize: 13.0, fontFamily: 'Dosis'),
                            ),
                            padding: EdgeInsets.only(left: 40.0, right: 40.0),
                          )),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      textColor: pressedButtonTextColor,
                    ),
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          pressedButtonColor = null;
                          pressedButtonTextColor =
                              Color.fromRGBO(187, 188, 189, 1.0);
                          notPressedButtonTextColor = Colors.white;
                          notPressedButtonColor =
                              Color.fromRGBO(170, 103, 167, 1.0);
                        });
                      },
                      color: notPressedButtonColor,
                      child: Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Padding(
                            child: Text(
                              'WEEK',
                              style: TextStyle(
                                  fontSize: 13.0, fontFamily: 'Dosis'),
                            ),
                            padding: EdgeInsets.only(left: 40.0, right: 40.0),
                          )),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      textColor: notPressedButtonTextColor,
                    )
                  ]),
            ),
            horoscope,
          ]));
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'HOROSCOPE',
            style: TextStyle(fontFamily: 'Dosis', fontSize: 20.0),
          ),
          backgroundColor: Color.fromRGBO(56, 107, 169, 1.0),
          elevation: 0.0,
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: <Widget>[
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
                  tileMode:
                      TileMode.repeated, // repeats the gradient over the canvas
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(image: AssetImage(selectedIconImage)),
                  Padding(
                    child: Text(
                      selectedIconName.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontFamily: 'Dosis',
                      ),
                    ),
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  ),
                  new Container(
                    height: 80.0,
                    child: new ListView(
                      scrollDirection: Axis.horizontal,
                      children: favorites
                          .map((String src) => IconButton(
                                icon: Image(
                                    image: AssetImage(
                                  src,
                                )),
                                iconSize: 44.0,
                                onPressed: () {
                                  setState(() {
                                    selectedIcon = src;
                                    if (selectedIcon ==
                                        'images/zodiac/icon_zodiac_white_aquarius.png') {
                                      selectedIconName = "Aquarius";
                                      selectedIconImage =
                                          'images/i_zodiac/i_aquarius.png';
                                    } else if (selectedIcon ==
                                        'images/zodiac/icon_zodiac_white_aries.png') {
                                      selectedIconName = "Aries";
                                      selectedIconImage =
                                          'images/i_zodiac/i_aries.png';
                                    } else if (selectedIcon ==
                                        'images/zodiac/icon_zodiac_white_cancer.png') {
                                      selectedIconName = "Cancer";
                                      selectedIconImage =
                                          'images/i_zodiac/i_cancer.png';
                                    } else if (selectedIcon ==
                                        'images/zodiac/icon_zodiac_white_capricorn.png') {
                                      selectedIconName = "Capricorn";
                                      selectedIconImage =
                                          'images/i_zodiac/i_capricorn.png';
                                    } else if (selectedIcon ==
                                        'images/zodiac/icon_zodiac_white_gemini.png') {
                                      selectedIconName = "Gemini";
                                      selectedIconImage =
                                          'images/i_zodiac/i_gemini.png';
                                    } else if (selectedIcon ==
                                        'images/zodiac/icon_zodiac_white_leo.png') {
                                      selectedIconName = "Leo";
                                      selectedIconImage =
                                          'images/i_zodiac/i_leo.png';
                                    } else if (selectedIcon ==
                                        'images/zodiac/icon_zodiac_white_libra.png') {
                                      selectedIconName = "Libra";
                                      selectedIconImage =
                                          'images/i_zodiac/i_libra.png';
                                    } else if (selectedIcon ==
                                        'images/zodiac/icon_zodiac_white_pisces.png') {
                                      selectedIconName = "Pisces";
                                      selectedIconImage =
                                          'images/i_zodiac/i_pisces.png';
                                    } else if (selectedIcon ==
                                        'images/zodiac/icon_zodiac_white_sagittarius.png') {
                                      selectedIconName = "Sagittarius";
                                      selectedIconImage =
                                          'images/i_zodiac/i_sagittarius.png';
                                    } else if (selectedIcon ==
                                        'images/zodiac/icon_zodiac_white_scorpio.png') {
                                      selectedIconName = "Scorpio";
                                      selectedIconImage =
                                          'images/i_zodiac/i_scorpio.png';
                                    } else if (selectedIcon ==
                                        'images/zodiac/icon_zodiac_white_taurus.png') {
                                      selectedIconName = "Taurus";
                                      selectedIconImage =
                                          'images/i_zodiac/i_taurus.png';
                                    } else if (selectedIcon ==
                                        'images/zodiac/icon_zodiac_white_virgo.png') {
                                      selectedIconName = "Virgo";
                                      selectedIconImage =
                                          'images/i_zodiac/i_virgo.png';
                                    }
                                    notPressedButtonTextColor =
                                        Color.fromRGBO(187, 188, 189, 1.0);
                                    notPressedButtonColor = null;
                                    pressedButtonColor =
                                        Color.fromRGBO(170, 103, 167, 1.0);
                                    pressedButtonTextColor = Colors.white;
                                  });
                                },
                              ))
                          .toList(),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          notPressedButtonTextColor =
                              Color.fromRGBO(187, 188, 189, 1.0);
                          notPressedButtonColor = null;
                          pressedButtonColor =
                              Color.fromRGBO(170, 103, 167, 1.0);
                          pressedButtonTextColor = Colors.white;

                        });
                      },
                      color: pressedButtonColor,
                      child: Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Padding(
                            child: Text(
                              'TODAY',
                              style: TextStyle(
                                fontSize: 13.0,
                                fontFamily: 'Dosis',
                              ),
                            ),
                            padding: EdgeInsets.only(left: 40.0, right: 40.0),
                          )),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      textColor: pressedButtonTextColor,
                    ),
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          pressedButtonColor = null;
                          pressedButtonTextColor =
                              Color.fromRGBO(187, 188, 189, 1.0);
                          notPressedButtonTextColor = Colors.white;
                          notPressedButtonColor =
                              Color.fromRGBO(170, 103, 167, 1.0);
                        });
                      },
                      color: notPressedButtonColor,
                      child: Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Padding(
                            child: Text(
                              'WEEK',
                              style: TextStyle(
                                fontSize: 13.0,
                                fontFamily: 'Dosis',
                              ),
                            ),
                            padding: EdgeInsets.only(left: 40.0, right: 40.0),
                          )),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      textColor: notPressedButtonTextColor,
                    )
                  ]),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: Divider()
            ),
            horoscope
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    this._fireStoreFetch();
    _loadingInProgress = true;
    _loadData();
  }

  Future _loadData() async {
    await new Future.delayed(new Duration(seconds: 3));
    _dataLoaded();
  }

  void _dataLoaded() {
    setState(() {
      _loadingInProgress = false;
    });
  }
}
