import 'dart:async';
import 'dart:convert';
import 'package:flutter_html_view/flutter_html_view.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class TodayHoroscope extends StatefulWidget {
  final String value;

  TodayHoroscope({Key key, this.value}) : super(key: key);

  @override
  _TodayHoroscopeState createState() => _TodayHoroscopeState();
}

class _TodayHoroscopeState extends State<TodayHoroscope> {
  var list;
  var random;

  final String url =
      "https://api.rss2json.com/v1/api.json?rss_url=https://www.wemystic.com/feed-horoscope-daily&api_key=e31qew7ogvak9hrtfybkk9kcelycciijergbhffj&count=12";
  List data;
  int selectedHoroscope;
  Widget horoscope;

  Future<String> getTodayHoroscope() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      var resBody = json.decode(res.body);
      data = resBody["items"];
      if (data[0]["title"] == "Daily Horoscope for ${widget.value}") {
        horoscope = HtmlView(
          data: data[0]["content"],
        );
      } else if (data[1]["title"] == "Daily Horoscope for ${widget.value}") {
        horoscope = HtmlView(
          data: data[1]["content"],
        );
      } else if (data[2]["title"] == "Daily Horoscope for ${widget.value}") {
        horoscope = HtmlView(
          data: data[2]["content"],
        );
      } else if (data[3]["title"] == "Daily Horoscope for ${widget.value}") {
        horoscope = HtmlView(
          data: data[3]["content"],
        );
      } else if (data[4]["title"] == "Daily Horoscope for ${widget.value}") {
        horoscope = HtmlView(
          data: data[4]["content"],
        );
      } else if (data[5]["title"] == "Daily Horoscope for ${widget.value}") {
        horoscope = HtmlView(
          data: data[5]["content"],
        );
      } else if (data[6]["title"] == "Daily Horoscope for ${widget.value}") {
        horoscope = HtmlView(
          data: data[6]["content"],
        );
      } else if (data[7]["title"] == "Daily Horoscope for ${widget.value}") {
        horoscope = HtmlView(
          data: data[7]["content"],
        );
      } else if (data[8]["title"] == "Daily Horoscope for ${widget.value}") {
        horoscope = HtmlView(
          data: data[8]["content"],
        );
      } else if (data[9]["title"] == "Daily Horoscope for ${widget.value}") {
        horoscope = HtmlView(
          data: data[9]["content"],
        );
      } else if (data[10]["title"] == "Daily Horoscope for ${widget.value}") {
        horoscope = HtmlView(
          data: data[10]["content"],
        );
      } else if (data[11]["title"] == "Daily Horoscope for ${widget.value}") {
        horoscope = HtmlView(
          data: data[11]["content"],
        );
      }
    });

    return "Success!";
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return new Container();
    } else {
      return SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 15.0),
              child: Column(children: <Widget>[
                SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        horoscope,
                      ],
                    ),
                  ),
                )
              ])));
    }
  }

  @override
  void initState() {
    const CircularProgressIndicator();
    this.getTodayHoroscope();
    super.initState();
  }
}
