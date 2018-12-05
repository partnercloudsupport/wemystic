
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wemystic/astrology/astrology_horoscope.dart';
import 'package:wemystic/login_page.dart';

class AstrologyChineseHoroscope extends StatefulWidget{
  @override
  _AstrologyChineseHoroscopeState createState() => _AstrologyChineseHoroscopeState();


}

class _AstrologyChineseHoroscopeState extends State<AstrologyChineseHoroscope>{
  String myText;
  Widget chineseSign;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  Future<Null> signOutWithGoogle() async {
    // Sign out with firebase
    await _auth.signOut();
    // Sign out with google
    await _googleSignIn.signOut();
  }

  _fireStoreFetch() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final DocumentReference docRef = Firestore.instance
        .collection("profile")
        .document("${user.uid.toString()}");
    docRef.get().then((dataSnapshot) {
      if (dataSnapshot.exists) {
        setState(() {
          myText = dataSnapshot.data['chinese_sign'];
          chineseSign = Text(myText);
        });
      }
    });
  }
  @override
  void initState() {
    super.initState();
    this._fireStoreFetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            FlatButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => AstrologyHoroscope(
                      )));
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                    ),
                    Text(
                      'HOROSCOPE CHINO',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ))
          ],
          backgroundColor: Color.fromRGBO(56, 107, 169, 1.0),
          elevation: 0.0,
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(children: <Widget>[
              myText == null
            ?Container()
                  : chineseSign,
              RaisedButton(
                onPressed: () {
                  signOutWithGoogle().then((Null) {
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) =>
                    new LoginPage()));
                  });
                },
                child: new Text("Sign out"),
                color: Colors.red,),
          ]),
        ));
  }

}