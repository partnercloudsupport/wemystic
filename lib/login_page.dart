import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wemystic/bottom_nav_bar.dart';
import 'package:wemystic/date_picker.dart';
import 'package:wemystic/pick_horoscope.dart';
import 'package:wemystic/we_mystic_news.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loadingInProgress;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  final FacebookLogin _facebookLogin = new FacebookLogin();

  Future<FirebaseUser> signInWithGoogle() async {
    // Attempt to get the currently authenticated user
    FacebookLoginStatus currentFbUser = FacebookLoginStatus.loggedIn;
    GoogleSignInAccount currentUser = _googleSignIn.currentUser;
    if (currentUser == null || currentFbUser == null) {
      // Attempt to sign in without user interaction
      currentUser = await _googleSignIn.signInSilently();
    }

    final GoogleSignInAuthentication auth = await currentUser.authentication;
    // Authenticate with firebase
    final FirebaseUser user = await _auth.signInWithGoogle(
      idToken: auth.idToken,
      accessToken: auth.accessToken,
    );

    assert(user != null);
    assert(!user.isAnonymous);

    return user;
  }

  String myText;

  _fireStoreFetch() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final DocumentReference docRef = Firestore.instance
        .collection("profile")
        .document("${user.uid.toString()}");
    docRef.get().then((dataSnapshot) {
      if (dataSnapshot.exists) {
        setState(() {
          myText = dataSnapshot.data['birth_date'];
          if (myText != null || dataSnapshot.data["aries"] != null) {
            new Future.delayed(new Duration(seconds: 5)).then((_) =>
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => HomePage(user: user))));
          } else if (myText != null) {
            new Future.delayed(new Duration(seconds: 5))
                .then((_) => Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => GridListDemo(
                          user: user,
                        ))));
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this._fireStoreFetch();
    // Listen for our auth event (on reload or start)
    // Go to our /todos page once logged in
    // Give the navigation animations, etc, some time to finish
    new Future.delayed(new Duration(seconds: 80))
        .then((_) => signInWithGoogle());
    _loadingInProgress = true;
    _loadData();
  }

  Future _loadData() async {
    await new Future.delayed(new Duration(seconds: 6));
    _dataLoaded();
  }

  void _dataLoaded() {
    setState(() {
      _loadingInProgress = false;
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 300.0, 0.0, 0.0) ,
                child: Image(
              image: AssetImage('images/launch_page_logo.png'),
            )),
            Image(
              image: AssetImage('images/launch_page_slogan.png'),
            )
          ],
        ),
      );
    } else {
      return new Center(
        child: Container(
          color: Color.fromRGBO(72, 67, 103, 1.0),
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 40.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 40.0)),
                  Container(
                      child: new Image.network(
                          'https://assets.wemystic.com/wmcom/2018/04/header-logo-white-png.png')),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 120.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Center(
                        child: RaisedButton(
                            child: Text('Login with Facebook'),
                            onPressed: () {
                              _facebookLogin.logInWithReadPermissions(
                                  ['email', 'public_profile']).then((result) {
                                // ignore: missing_enum_constant_in_switch
                                switch (result.status) {
                                  case FacebookLoginStatus.loggedIn:
                                    FirebaseAuth.instance
                                        .signInWithFacebook(
                                            accessToken:
                                                result.accessToken.token)
                                        .then((user) {
                                      print('Signed in as ${user.displayName}');
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  BornDate(
                                                    user: user,
                                                  )));
                                    }).catchError((e) {
                                      print(e);
                                    });
                                }
                              }).catchError((e) {
                                print(e);
                              });
                            }),
                      ),
                      Center(
                          child: RaisedButton(
                              child: Text('LoginGoogle'),
                              onPressed: () {
                                _googleSignIn.signIn();
                                signInWithGoogle().then((user) {
                                  print('Signed in as ${user.displayName}');
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          BornDate(
                                            user: user,
                                          )));
                                });
                              }))
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }
  }
}
