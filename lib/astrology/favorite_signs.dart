import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  @override
  _ImageCarouselState createState() => new _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  bool aquarius;
  bool aries;
  bool cancer;
  bool capricorn;
  bool gemini;
  bool leo;
  bool libra;
  bool pisces;
  bool scorpio;
  bool taurus;
  bool virgo;
  bool sagittarius;
  List favorites = new List();

  _fireStoreFetch() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final DocumentReference docRef = Firestore.instance
        .collection("profile")
        .document("${user.uid.toString()}");
    docRef.get().then((dataSnapshot) {
      if (dataSnapshot.exists) {
        setState(() {
          aquarius = dataSnapshot.data['aquarius'];
          aries = dataSnapshot.data['aries'];
          cancer = dataSnapshot.data['cancer'];
          capricorn = dataSnapshot.data['capricorn'];
          gemini = dataSnapshot.data['gemini'];
          leo = dataSnapshot.data['leo'];
          libra = dataSnapshot.data['libra'];
          pisces = dataSnapshot.data['pisces'];
          sagittarius = dataSnapshot.data['sagittarius'];
          scorpio = dataSnapshot.data['scorpio'];
          taurus = dataSnapshot.data['taurus'];
          virgo = dataSnapshot.data['virgo'];
          if (aquarius == true) {
            favorites.add(
                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-aquario.png');
          }
          if (aries == true) {
            favorites.add(
                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-aries.png');
          }
          if (cancer == true) {
            favorites.add(
                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-caranguejo.png');
          }
          if (capricorn == true) {
            favorites.add(
                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-capricornio.png');
          }
          if (gemini == true) {
            favorites.add(
                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-gemeos.png');
          }
          if (leo == true) {
            favorites.add(
                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-leao.png');
          }
          if (libra == true) {
            favorites.add(
                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-libra.png');
          }
          if (pisces == true) {
            favorites.add(
                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-peixes.png');
          }
          if (sagittarius == true) {
            favorites.add(
                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-sagitario.png');
          }
          if (scorpio == true) {
            favorites.add(
                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-escorpiao.png');
          }
          if (taurus == true) {
            favorites.add(
                'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-touro.png');
          }
          if (virgo == true) {
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
    return Container(
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              0 < favorites.length
                  ? IconButton(
                      icon: Image.network(favorites[0]),
                      onPressed: null,
                    )
                  : Container(),
              1 < favorites.length
                  ? IconButton(
                      icon: Image.network(favorites[1]),
                      onPressed: null,
                    )
                  : Container(),
              2 < favorites.length
                  ? IconButton(
                      icon: Image.network(favorites[2]),
                      onPressed: null,
                    )
                  : Container(),
              3 < favorites.length
                  ? IconButton(
                      icon: Image.network(favorites[3]),
                      onPressed: null,
                    )
                  : Container(),
              4 < favorites.length
                  ? IconButton(
                      icon: Image.network(favorites[4]),
                      onPressed: null,
                    )
                  : Container(),
              5 < favorites.length
                  ? IconButton(
                      icon: Image.network(favorites[5]),
                      onPressed: null,
                    )
                  : Container(),
              6 < favorites.length
                  ? IconButton(
                      icon: Image.network(favorites[6]),
                      onPressed: null,
                    )
                  : Container(),
              7 < favorites.length
                  ? IconButton(
                      icon: Image.network(favorites[7]),
                      onPressed: null,
                    )
                  : Container(),
              8 < favorites.length
                  ? IconButton(
                      icon: Image.network(favorites[8]),
                      onPressed: null,
                    )
                  : Container(),
              9 < favorites.length
                  ? IconButton(
                      icon: Image.network(favorites[9]),
                      onPressed: null,
                    )
                  : Container(),
              10 < favorites.length
                  ? IconButton(
                      icon: Image.network(favorites[10]),
                      onPressed: null,
                    )
                  : Container(),
              11 < favorites.length
                  ? IconButton(
                      icon: Image.network(favorites[11]),
                      onPressed: null,
                    )
                  : Container(),
            ]));
  }
}
