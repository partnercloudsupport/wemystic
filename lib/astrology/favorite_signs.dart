import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoritesSigns extends StatefulWidget {
  @override
  _FavoriteSignsState createState() => new _FavoriteSignsState();
}

class _FavoriteSignsState extends State<FavoritesSigns> {


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
  List<String> favorites = new List();
  String selectedIcon;



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
    if (selectedIcon == null){
      return Column(
          children: <Widget>[
      Row(children: favorites.map((String src) => IconButton(
        icon: Image.network(src),
        onPressed: (){
          setState(() {
            return selectedIcon = src;
          });
        },
      )).toList(),)
    ]);
    }else{
      return Column(
        children: <Widget>[
          Row(children: favorites.map((String src) => IconButton(
            icon: Image.network(src),
            onPressed: (){
              setState(() {
                selectedIcon = src;
              });
            },
          )).toList(),),
          Container(
            child: Image.network(selectedIcon),
          )
        ],
      );
    }

  }
}
