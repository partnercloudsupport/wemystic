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
  bool _loadingInProgress;

  @override
  void initState() {
    super.initState();
    _loadingInProgress = true;
    _loadData();
  }

  Future _loadData() async {
    await new Future.delayed(new Duration(seconds: 3));
    _dataLoaded();
  }

  void _dataLoaded() {
    setState(() {
      _loadingInProgress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loadingInProgress) {
      return new Container(
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
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
          ),
        ),
        child: Container(
          alignment: Alignment(0.0, 0.0),
          child: Image(image: AssetImage('images/loading_icon.png')),
        ),
      );
    } else if (horoscopeCategory == "zodiac") {
      return Scaffold(
          appBar: AppBar(
            title: FlatButton(
                onPressed: () {
                  setState(() {
                    horoscopeCategory = "chinese";
                  });
                },
                child: Row(
                  children: <Widget>[
                    Text('Chinese Horoscope', style: TextStyle(
                      color: Colors.white,

                    ),),
                    Icon(Icons.arrow_forward_ios)
                  ],
                )),
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
                    Icon(Icons.arrow_back_ios),
                    Text('Chinese Horoscope'),
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
