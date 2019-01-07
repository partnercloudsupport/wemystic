import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wemystic/astrology/astrology_chinese.dart';
import 'package:wemystic/astrology/astrology_horoscope.dart';

class AstrologyHeader extends StatefulWidget {
  @override
  _AstrologyHeaderState createState() => _AstrologyHeaderState();
}

class _AstrologyHeaderState extends State<AstrologyHeader> {
  String horoscopeCategory = "zodiac";


  @override
  Widget build(BuildContext context) {
   if (horoscopeCategory == "zodiac") {
      return Scaffold(
        resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            title: Column(
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                          onPressed: () {
                            setState(() {
                              horoscopeCategory = "chinese";
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Chinese Horoscope',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Dosis',
                                  fontSize: 19.0,
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 5.0),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                  ))
                            ],
                          )),
                    ]),
              ],
            ),
            backgroundColor: Color.fromRGBO(56, 107, 169, 1.0),
            elevation: 0.0,
            automaticallyImplyLeading: false,
          ),
          body: AstrologyHoroscope());
    } else {
      return Scaffold(
          appBar: AppBar(
            title: FlatButton(
                onPressed: () {
                  setState(() {
                    horoscopeCategory = "zodiac";
                  });
                },
                child: Row(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Icon(Icons.arrow_back_ios, color: Colors.white)),
                    Text(
                      'Zodiac Horoscope',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Dosis',
                        fontSize: 19.0,
                      ),
                    ),
                  ],
                )),
            backgroundColor: Color.fromRGBO(56, 107, 169, 1.0),
            elevation: 0.0,
            automaticallyImplyLeading: false,
          ),
          body: AstrologyChinese());
    }
  }
}
