import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wemystic/new_detail.dart';
import 'package:flutter_date_picker/flutter_date_picker.dart';




class WeMysticNewsData extends StatefulWidget {
  @override
  WeMysticNewsState createState() => WeMysticNewsState();
}


class WeMysticNewsState extends State<WeMysticNewsData> {
  var list;
  var random;

  final String url =
      "https://api.rss2json.com/v1/api.json?rss_url=https://www.wemystic.com/feed";
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("We Mystic News"),
          backgroundColor: Colors.deepPurpleAccent,
          automaticallyImplyLeading: false,
        ),
        body: RefreshIndicator(
            child: ListView.builder(
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int index) {
                return new Container(
                  padding: EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 15.0),
                  child: Column(
                    children : <Widget> [
                      Column(
                        children: <Widget>[

                          new Card(
                            child: new Column(children: <Widget>[
                              new Image.network(
                                data[index]["enclosure"]["link"],
                              ),
                              new Padding(
                                padding: EdgeInsets.all(5.0),
                                child: new Text(
                                  data[index]["title"],
                                  maxLines: 3,

                                  style: TextStyle(
                                    //fontFamily: 'Dosis-ExtraBold',
                                    fontSize: 18.0,
                                    color: Color.fromRGBO(127, 108, 157, 1.0),
                                  ),
                                ),
                              ),
                              new Padding(
                                padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
                                child: new Text(data[index]["description"],
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      //  fontFamily: 'Roboto-Light',
                                      fontSize: 14.0,
                                      color: Colors.black,
                                    )),
                              ),
                              new ButtonTheme.bar(
                                child: new ButtonBar(
                                  alignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    new FlatButton(
                                      child: const Text('SHARE'),
                                      textColor: Colors.amber.shade500,
                                      onPressed: () {},
                                    ),
                                    new FlatButton(
                                      child: const Text('EXPLORE'),
                                      textColor: Colors.amber.shade500,
                                      onPressed: () {
                                        var route = new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                          new NewDetail(
                                              value: data[index]["content"]
                                                  .toString(),
                                              thumbnail: data[index]["thumbnail"]
                                                  .toString()),
                                        );
                                        Navigator.of(context).push(route);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ]),
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
    );
  }

  @override
  void initState() {
    super.initState();
    this.getWMNews();
  }
}
