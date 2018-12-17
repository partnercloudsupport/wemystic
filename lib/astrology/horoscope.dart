import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Horoscope extends StatefulWidget {
  @override
  _HoroscopeState createState() => _HoroscopeState();
}

class _HoroscopeState extends State<Horoscope> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0),
      child: Column(
        children: <Widget>[
          Divider(),
          Text(
              'Here, you can find out more about the daily Horoscope for Taurus. Every day, WeMystic will bring you the forecast for Love and Relationships, Health and Money & Career.'),
          Padding(
            padding: EdgeInsets.only(left: 50.0, right: 50.0),
            child: Text('DAILY HOROSCOPE FOR TAURUS'),
          ),
          Container(
            color: Color.fromRGBO(237, 239, 240, 1.0),
            child: Row(
              children: <Widget>[
                Image(image: AssetImage('images/icon_horoscope_love.png'),)
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
