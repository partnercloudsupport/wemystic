import 'dart:async';
import 'package:flutter_html_view/flutter_html_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wemystic/login_page.dart';

class NewDetail extends StatefulWidget {
  final String value;
  final String thumbnail;
//git test
  NewDetail({Key key, this.value, this.thumbnail}) : super (key: key);

  @override
  _NewDetailState createState() => _NewDetailState();
}


class _NewDetailState extends State<NewDetail> {
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
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("test"),

      ),
      body: new SingleChildScrollView(
        child: new Center(
            child: new Column(
                children: <Widget>[
            new RaisedButton(
            onPressed: () {
              signOutWithGoogle().then((Null) {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) =>
                new LoginPage()));
              });
            },
        child: new Text("Sign out"),
        color: Colors.red,),
        new Image.network("${widget.thumbnail}"),
        new HtmlView(data: "${widget.value}"),

        ],
      ),

    ),)

    );
  }

}
