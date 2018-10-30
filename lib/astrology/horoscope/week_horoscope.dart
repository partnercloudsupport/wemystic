import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class WeekHoroscope extends StatelessWidget{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  Future<Null> signOutWithGoogle() async {
    // Sign out with firebase
    await _auth.signOut();
    // Sign out with google
    await _googleSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(


      child: RaisedButton(onPressed: (){
        signOutWithGoogle();
      }),
    );
  }
}