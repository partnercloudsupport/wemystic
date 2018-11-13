import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoritesSigns extends StatefulWidget {
  @override
  _FavoriteSignsState createState() => new _FavoriteSignsState();
}

class _FavoriteSignsState extends State<FavoritesSigns> {
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

  _fireStoreFetch() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final DocumentReference docRef = Firestore.instance
        .collection("profile")
        .document("${user.uid.toString()}");
    docRef.get().then((dataSnapshot) {
      if (dataSnapshot.exists) {
        setState(() {
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

  initState() {
    super.initState();
    this._fireStoreFetch();
  }

  @override
  Widget build(BuildContext context) {
    if (selectedIcon == null) {
      return Column(children: <Widget>[
        Row(
          children: favorites
              .map((String src) => IconButton(
                    icon: Image.network(
                      src,
                    ),
                    onPressed: () {
                      setState(() {
                        return selectedIcon = src;
                      });
                    },
                  ))
              .toList(),
        )
      ]);
    } else {
      return Column(
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
              children: <Widget>[
                Image.network(selectedIcon),
              ],
            ),
            Row(
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
      );
    }
  }
}
