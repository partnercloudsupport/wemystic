import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_picker/flutter_date_picker.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wemystic/bottom_nav_bar.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:wemystic/date_picker.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

  @override
  void initState() {
    super.initState();

    // Listen for our auth event (on reload or start)
    // Go to our /todos page once logged in
    _auth.onAuthStateChanged.firstWhere((user) => user != null).then((user) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => BornDate(
                user: user,
              )));
    });

    // Give the navigation animations, etc, some time to finish
    new Future.delayed(new Duration(seconds: 1))
        .then((_) => signInWithGoogle());
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: Center(
            child: Column(children: <Widget>[
      RaisedButton(
          child: Text('LoginFacebook'),
          onPressed: () {
            _facebookLogin.logInWithReadPermissions(
                ['email', 'public_profile']).then((result) {
              switch (result.status) {
                case FacebookLoginStatus.loggedIn:
                  FirebaseAuth.instance
                      .signInWithFacebook(accessToken: result.accessToken.token)
                      .then((user) {
                    print('Signed in as ${user.displayName}');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => BornDate(
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
      RaisedButton(
          child: Text('LoginGoogle'),
          onPressed: () {
            _googleSignIn.signIn();
            signInWithGoogle().then((user) {
              print('Signed in as ${user.displayName}');
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => BornDate(
                        user: user,
                      )));
            });
          })
    ])));
  }
}
