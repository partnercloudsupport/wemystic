import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share/share.dart';

class WeMysticNewsData extends StatefulWidget {
  @override
  WeMysticNewsState createState() => WeMysticNewsState();
}

class WeMysticNewsState extends State<WeMysticNewsData> {
  var list;
  var random;

  final String url =
      "https://api.rss2json.com/v1/api.json?rss_url=https://www.wemystic.com/feed";

  // Instance of WebView plugin
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  // On destroy stream
  StreamSubscription _onDestroy;

  List data;

  Future<String> getWMNews() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      var resBody = json.decode(res.body);
      data = resBody["items"];
    });

    return "Success!";
  }

  @override
  void dispose() {
    _onDestroy.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "WEMYSTIC NEWS",
            style: TextStyle(fontFamily: 'Dosis'),
          ),
          backgroundColor: Color.fromRGBO(56, 107, 169, 1.0),
          elevation: 0.0,
          automaticallyImplyLeading: false,
        ),
        body: Container(
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
              tileMode:
                  TileMode.repeated, // repeats the gradient over the canvas
            ),
          ),
          child: RefreshIndicator(
            child: ListView.builder(
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int index) {
                return new Container(
                  padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          new Card(
                            child: new Column(children: <Widget>[
                              new Image.network(
                                data[index]["enclosure"]["link"],
                              ),
                              new Padding(
                                padding: EdgeInsets.all(15.0),
                                child: new Text(
                                  data[index]["title"].toString().toUpperCase(),
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontFamily: 'Dosis',
                                    fontSize: 18.0,
                                    color: Color.fromRGBO(127, 108, 157, 1.0),
                                  ),
                                ),
                              ),
                              new Padding(
                                padding:
                                    EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
                                child: new Text(
                                  data[index]["description"],
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 14.0,
                                    color: Colors.black,
                                  ),
                                  maxLines: 3,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                                child: Divider(),
                              ),
                              new ButtonTheme.bar(
                                child: new ButtonBar(
                                  alignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new FlatButton(
                                      child: Icon(
                                        Icons.share,
                                        color: Colors.white,
                                      ),
                                      color: Color.fromRGBO(68, 153, 213, 1.0),
                                      shape: CircleBorder(),
                                      onPressed: () {
                                        Share.share(
                                          data[index]["link"],
                                        );
                                      },
                                    ),
                                    FlatButton(
                                      color: Color.fromRGBO(161, 108, 164, 1.0),
                                      child: const Text(
                                        'READ ARTICLE',
                                        style: TextStyle(fontFamily: 'Dosis'),
                                      ),
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30.0)),
                                      textColor: Colors.white,
                                      onPressed: () {
                                        launch(data[index]["link"],
                                            forceWebView: false);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                            margin: const EdgeInsets.all(10.0),
                          )
                        ],
                      )
                    ],
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                  ),
                );
              },
            ),
            onRefresh: getWMNews,
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.close();
    this.getWMNews();
  }
}
