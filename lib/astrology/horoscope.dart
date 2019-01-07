import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Horoscope extends StatefulWidget {
  @override
  _HoroscopeState createState() => _HoroscopeState();
}

class _HoroscopeState extends State<Horoscope> {
  @override
  Widget build(BuildContext context) {
        return Expanded(
            child: Container(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                      child: Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0),
                          child: Column(children: <Widget>[
                            Divider(),
                            Text(
                                'Here, you can find out more about the daily Horoscope for Taurus. Every day, WeMystic will bring you the forecast for Love and Relationships, Health and Money & Career.'),
                            Padding(
                              padding: EdgeInsets.only(left: 50.0, right: 50.0),
                              child: Text('DAILY HOROSCOPE FOR TAURUS'),
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 15.0),
                                child: Container(
                                    color: Color.fromRGBO(237, 239, 240, 1.0),
                                    child: Column(children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Image(
                                                image: AssetImage(
                                                    'images/icon_horoscope_love.png'),
                                                width: 20.0,
                                              )),
                                          Text('Love and Relationships')
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                            'astdfghdfghjsddgfhgjsdkfdsgdfsgdfsgkjfdskljfdskjjkfkjfkkfjsdkjfdsfsjgksfgjfdsakjajkgfkjgkjfas'),
                                      ),
                                    ]))),
                            Padding(
                                padding: EdgeInsets.only(top: 15.0),
                                child: Container(
                                    color: Color.fromRGBO(237, 239, 240, 1.0),
                                    child: Column(children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Image(
                                                image: AssetImage(
                                                    'images/icon_horoscope_love.png'),
                                                width: 20.0,
                                              )),
                                          Text('Love and Relationships')
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                            'astdfghdfghjsddgfhgjsdkfdsgdfsgdfsgkjfdskljfdskjjkfkjfkkfjsdkjfdsfsjgksfgjfdsakjajkgfkjgkjfas'),
                                      ),
                                    ]))),
                            Padding(
                              padding: EdgeInsets.only(top: 15.0),
                              child: Container(
                                  color: Color.fromRGBO(237, 239, 240, 1.0),
                                  child: Column(children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Image(
                                              image: AssetImage(
                                                  'images/icon_horoscope_love.png'),
                                              width: 20.0,
                                            )),
                                        Text('Love and Relationships')
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(
                                          'astdfgeedhfgjklfdsfdsfddfsgffdgdfsgsgdffdgsfdgsdfgsdfggffdgfddsdhdfghjsddgfhgjsdkfdsgdfsgdfsgkjfdskljfdskjjkfkjfkkfjsdkjfdsfsjgksfgjfdsakjajkgfkjgkjfas'),
                                    ),
                                  ])),
                            )
                          ])),
                    ),
                  ],
                ))
        );
  }
}
