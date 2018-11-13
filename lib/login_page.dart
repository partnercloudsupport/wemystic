import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wemystic/date_picker.dart';

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
    new Future.delayed(new Duration(seconds: 80))
        .then((_) => signInWithGoogle());
    _loadingInProgress = true;
    _loadData();
  }

  Future _loadData() async {
    await new Future.delayed(new Duration(seconds: 5));
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
      return new Center(
        child: new Image.network(
            'https://assets.wemystic.com/wmcom/2018/04/header-logo-white-png.png'),
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
            Padding(padding: EdgeInsets.only( top: 120.0),),
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
                                      accessToken: result.accessToken.token)
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
                                    builder: (BuildContext context) => BornDate(
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
