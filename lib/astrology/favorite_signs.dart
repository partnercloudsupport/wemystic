import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  _ImageCarouselState createState() => new _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel>
    with SingleTickerProviderStateMixin {
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
  List favorites;

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
          favorites = [
            aquarius,
            aries,
            cancer,
            capricorn,
            gemini,
            leo,
            libra,
            pisces,
            sagittarius,
            scorpio,
            taurus,
            virgo,
          ];
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
        child: Row(children: <Widget>[
      Row(
        children: <Widget>[
          aquarius == true
              ? IconButton(
                  icon: Image.network(
                      'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-aquario.png'),
                  onPressed: null)
              : null,
          aries == true
              ? IconButton(
                  icon: Image.network(
                      'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-aries.png'),
                  onPressed: null)
              : null,
          cancer == true
              ? IconButton(
                  icon: Image.network(
                      'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-cancer.png'),
                  onPressed: null)
              : null,
          capricorn == true
              ? IconButton(
                  icon: Image.network(
                      'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-capricorn.png'),
                  onPressed: null)
              : null,
        ],
      ),
      Row(
        children: <Widget>[
          gemini == true
              ? IconButton(
                  icon: Image.network(
                      'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-gemini.png'),
                  onPressed: null)
              : null,
          leo == true
              ? IconButton(
                  icon: Image.network(
                      'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-leo.png'),
                  onPressed: null)
              : null,
          libra == true
              ? IconButton(
                  icon: Image.network(
                      'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-libra.png'),
                  onPressed: null)
              : null,
          pisces == true
              ? IconButton(
                  icon: Image.network(
                      'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-pisces.png'),
                  onPressed: null)
              : null,
        ],
      ),
      Row(
        children: <Widget>[
          sagittarius == true
              ? IconButton(
                  icon: Image.network(
                      'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-sagittarius.png'),
                  onPressed: null)
              : null,
          scorpio == true
              ? IconButton(
                  icon: Image.network(
                      'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-scorpio.png'),
                  onPressed: null)
              : null,
          taurus == true
              ? IconButton(
                  icon: Image.network(
                      'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-taurus.png'),
                  onPressed: null)
              : null,
          virgo == true
              ? IconButton(
                  icon: Image.network(
                      'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-virgo.png'),
                  onPressed: null)
              : null,
        ],
      ),
    ]));
  }
}
