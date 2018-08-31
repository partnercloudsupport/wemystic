import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:wemystic/bottom_nav_bar.dart';

class LoginFacebook extends StatefulWidget {
  @override
  _LoginFacebookState createState() => _LoginFacebookState();
}

class _LoginFacebookState extends State<LoginFacebook> {
  FacebookLogin fbLogin = new FacebookLogin();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: RaisedButton(
          child: Text('LoginFacebook'),
          onPressed: () {
            fbLogin.logInWithReadPermissions(['email', 'public_profile'])
                .then((result) {
              switch(result.status) {
                case FacebookLoginStatus.loggedIn:
                  FirebaseAuth.instance.signInWithFacebook(
                      accessToken: result.accessToken.token
                  ).then((user) {
                    print('Signed in as ${user.displayName}');
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                        builder: (BuildContext context) => HomePage(
                        user: user,)));
                  }).catchError((e) {
                    print(e);
                  });
              }
            }).catchError((e) {
              print(e);
            });
          }),
    );
  }
}

