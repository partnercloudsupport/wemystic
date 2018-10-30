import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:wemystic/new_detail.dart';

class AstrologyMoon extends StatefulWidget {
  @override
  _AstrologyMoonState createState() => _AstrologyMoonState();
}

class _AstrologyMoonState extends State<AstrologyMoon> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();

  Future<Null> signOutWithGoogle() async {
    // Sign out with firebase
    await _auth.signOut();
    // Sign out with google
    await _googleSignIn.signOut();
  }

  final String url =
      "https://api.rss2json.com/v1/api.json?rss_url=https://www.wemystic.com/astrology/moon/feed";
  List data;

  Future<String> getAMNews() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      var resBody = json.decode(res.body);
      data = resBody["items"];
    });

    return "Success!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RaisedButton(
      onPressed: () {
        signOutWithGoogle();
      },
      child: Text("signOut"),
    ));
  }

  @override
  void initState() {
    super.initState();
    this.getAMNews();
  }
}
