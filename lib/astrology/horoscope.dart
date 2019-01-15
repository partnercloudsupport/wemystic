import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:share_api/share_api.dart';

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
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    'Here, you can find out more about the daily Horoscope for Taurus. Every day, WeMystic will bring you the forecast for Love and Relationships, Health and Money & Career.',
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 14.0),
                    textAlign: TextAlign.justify,
                  ),
                ),

                  Text(
                    'DAILY HOROSCOPE FOR TAURUS',
                    style: TextStyle(
                        fontFamily: 'Dosis',
                        fontSize: 18.0,
                        color: Color.fromRGBO(127, 108, 157, 1.0)),
                    textAlign: TextAlign.center,
                  ),

                Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Container(
                        color: Color.fromRGBO(237, 239, 240, 1.0),
                        child: Column(children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Image(
                                    image: AssetImage(
                                        'images/icon_horoscope_love.png'),
                                    width: 20.0,
                                  )),
                              Text(
                                'LOVE AND RELATIONSHIPS',
                                style: TextStyle(
                                    fontFamily: 'Dosis',
                                    fontSize: 18.0,
                                    color: Color.fromRGBO(127, 108, 157, 1.0)),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 15.0, right: 15.0, bottom: 5.0),
                            child: Text(
                                'Today is a good day to strengthen your ties with your partner. Go out to have fun, prepare a more intimate dinner and escape to a different place.',
                                style: TextStyle(
                                    fontFamily: 'Roboto', fontSize: 14.0),
                                textAlign: TextAlign.justify),
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
                                      'images/icon_horoscope_money.png'),
                                  width: 20.0,
                                )),
                            Text('MONEY AND CAREER')
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                              'Soon you will be surprised with an excellent opportunity to present your opinions. Colleagues and superiors should praise you.'),
                        ),
                      ])),
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
                                        'images/icon_horoscope_health.png'),
                                    width: 20.0,
                                  )),
                              Text('HEALTH')
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                                'You should start to reap good fruits with regard to your health. His effort is reflected in his appearance, even after some change.'),
                          ),
                        ]))),
              ])),
        ),
      ],
    )));
  }
}
