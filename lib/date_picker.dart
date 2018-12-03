import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:wemystic/pick_horoscope.dart';

class BornDate extends StatefulWidget {
  final FirebaseUser user;

  BornDate({Key key, this.user}) : super(key: key);

  @override
  _BornDateState createState() => _BornDateState();
}

class _BornDateState extends State<BornDate> {
  bool _loadingInProgress;

  FirebaseUser user;
  String myText;
  String _datetime = '';
  int _year = DateTime.now().year;
  int _month = DateTime.now().month;
  int _date = DateTime.now().day;
  String zodiacSign;
  String chineseSign;
  String chineseSignElement;

  String _lang = 'en';
  String _format = 'dd-mm-yyyy';
  bool _showTitleActions = true;

  TextEditingController _langCtrl = TextEditingController();
  TextEditingController _formatCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _langCtrl.text = 'en';
    _formatCtrl.text = 'dd-mm-yyyy';

    DateTime now = DateTime.now();
    _year = now.year;
    _month = now.month;
    _date = now.day;
    this._fireStoreFetch();
    _loadingInProgress = true;
    _loadData();
  }

  Future _loadData() async {
    await new Future.delayed(new Duration(seconds: 5));
    _dataLoaded();
  }

  void _dataLoaded() {
    setState(() {
      _loadingInProgress = false;
    });
  }

  _fireStoreFetch() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final DocumentReference docRef = Firestore.instance
        .collection("profile")
        .document("${user.uid.toString()}");
    docRef.get().then((dataSnapshot) {
      if (dataSnapshot.exists) {
        setState(() {
          myText = dataSnapshot.data['birth_date'];
          if (myText != null) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => GridListDemo(
                  user: user,
                )));
          }
        });
      }
    });
  }

  /// Display date picker.
  void _showDatePicker() {
    final bool showTitleActions = false;
    DatePicker.showDatePicker(
      context,
      showTitleActions: _showTitleActions,
      minYear: 1970,
      maxYear: DateTime.now().year,
      initialYear: _year,
      initialMonth: _month,
      initialDate: _date,
      confirm: Text(
        'custom ok',
        style: TextStyle(color: Colors.red),
      ),
      cancel: Text(
        'custom cancel',
        style: TextStyle(color: Colors.cyan),
      ),
      locale: _lang,
      dateFormat: _format,
      onChanged: (year, month, date) {
        debugPrint('onChanged date: $year-$month-$date');

        if (!showTitleActions) {
          _changeDatetime(year, month, date);
        }
      },
      onConfirm: (year, month, date) {
        _changeDatetime(year, month, date);
      },
    );
  }

  void _changeDatetime(int year, int month, int date) {
    setState(() {
      _year = year;
      _month = month;
      _date = date;
      _datetime = '$date-$month-$year';
    });
  }
  _fireStoreAdd() async {

    if (_month == 12) {
      if (_date < 22)
        zodiacSign = "Sagittarius";
      else
        zodiacSign = "Capricorn";
    } else if (_month == 01) {
      if (_date < 20)
        zodiacSign = "Capricorn";
      else
        zodiacSign = "Aquarius";
    } else if (_month == 02) {
      if (_date < 19)
        zodiacSign = "Aquarius";
      else
        zodiacSign = "Pisces";
    } else if (_month == 03) {
      if (_date < 21)
        zodiacSign = "Pisces";
      else
        zodiacSign = "Aries";
    } else if (_month == 04) {
      if (_date < 20)
        zodiacSign = "Aries";
      else
        zodiacSign = "Taurus";
    } else if (_month == 05) {
      if (_date < 21)
        zodiacSign = "Taurus";
      else
        zodiacSign = "Gemini";
    } else if (_month == 06) {
      if (_date < 21)
        zodiacSign = "Gemini";
      else
        zodiacSign = "Cancer";
    } else if (_month == 07) {
      if (_date < 23)
        zodiacSign = "Cancer";
      else
        zodiacSign = "Leo";
    } else if (_month == 08) {
      if (_date < 23)
        zodiacSign = "Leo";
      else
        zodiacSign = "Virgo";
    } else if (_month == 09) {
      if (_date < 23)
        zodiacSign = "Virgo";
      else
        zodiacSign = "Libra";
    } else if (_month == 10) {
      if (_date < 23)
        zodiacSign = "Libra";
      else
        zodiacSign = "Scorpio";
    } else if (_month == 11) {
      if (_date < 22)
        zodiacSign = "Scorpio";
      else
        zodiacSign = "Sagittarius";
    }
    if (_year == 2008 ||
        _year == 1996 ||
        _year == 1984 ||
        _year == 1972 ||
        _year == 1960) {
      chineseSign = "Rat";
    } else if (_year == 2009 ||
        _year == 1997 ||
        _year == 1985 ||
        _year == 1973 ||
        _year == 1961) {
      chineseSign = "Ox";
    } else if (_year == 2010 ||
        _year == 1998 ||
        _year == 1986 ||
        _year == 1974 ||
        _year == 1962) {
      chineseSign = "Tiger";
    } else if (_year == 2011 ||
        _year == 1999 ||
        _year == 1987 ||
        _year == 1975 ||
        _year == 1963) {
      chineseSign = "Rabbit";
    } else if (_year == 2012 ||
        _year == 2000 ||
        _year == 1988 ||
        _year == 1976 ||
        _year == 1954) {
      chineseSign = "Dragon";
    } else if (_year == 2013 ||
        _year == 2001 ||
        _year == 1989 ||
        _year == 1977 ||
        _year == 1965) {
      chineseSign = "Snake";
    } else if (_year == 2014 ||
        _year == 2002 ||
        _year == 1990 ||
        _year == 1978 ||
        _year == 1966) {
      chineseSign = "Horse";
    } else if (_year == 2015 ||
        _year == 2003 ||
        _year == 1991 ||
        _year == 1979 ||
        _year == 1967) {
      chineseSign = "Goat";
    } else if (_year == 2016 ||
        _year == 2004 ||
        _year == 1992 ||
        _year == 1980 ||
        _year == 1968) {
      chineseSign = "Monkey";
    } else if (_year == 2017 ||
        _year == 2005 ||
        _year == 1993 ||
        _year == 1981 ||
        _year == 1969) {
      chineseSign = "Rooster";
    } else if (_year == 2018 ||
        _year == 2006 ||
        _year == 1994 ||
        _year == 1982 ||
        _year == 1970) {
      chineseSign = "Dog";
    } else if (_year == 2019 ||
        _year == 2007 ||
        _year == 1995 ||
        _year == 1983 ||
        _year == 1971) {
      chineseSign = "Pig";
    }
    if (_year.toString().substring(3, 4) == '0' ||
        _year.toString().substring(3, 4) == '1') {
      chineseSignElement = "Metal";
    } else if (_year.toString().substring(3, 4) == '2' ||
        _year.toString().substring(3, 4) == '3') {
      chineseSignElement = "Water";
    } else if (_year.toString().substring(3, 4) == '4' ||
        _year.toString().substring(3, 4) == '5') {
      chineseSignElement = "Wood";
    } else if (_year.toString().substring(3, 4) == '6' ||
        _year.toString().substring(3, 4) == '7') {
      chineseSignElement = "Fire";
    } else if (_year.toString().substring(3, 4) == '8' ||
        _year.toString().substring(3, 4) == '9') {
      chineseSignElement = "Earth";
    }
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final DocumentReference docRef = Firestore.instance
        .collection("profile")
        .document("${user.uid.toString()}");
    Map<String, String> data = <String, String>{
      "birth_date": _datetime,
      "zodiac_sign": zodiacSign,
      "chinese_sign": '$chineseSign $chineseSignElement',
    };
    docRef.setData(data).whenComplete(() {
      print("Document added");
    }).catchError((e) => print(e));
  }


  @override
  Widget build(BuildContext context) {
    if (_loadingInProgress) {
      return new Container(
          color: Color.fromRGBO(72, 67, 103, 1.0),
          child: Center(
            child: new Image.network(
                'https://assets.wemystic.com/wmcom/2018/04/header-logo-white-png.png'),
          ));
    } else {
      return new Container(
        color: Color.fromRGBO(237, 239, 240, 1.0),
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 100.0)),
            Image(
              image: AssetImage('images/logo_color.png'),
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                'Pick your birth date',
                style: TextStyle(
                  color: Color.fromRGBO(102, 103, 104, 1.0),
                  fontSize: 14.0,
                ),
              ),
            ),
            FlatButton(
              padding: EdgeInsets.only(left: 12.0),
              child: _datetime == ''
                  ? Text('DD/MM/YYYY')
                  : Text(
                '$_datetime',
                style: Theme
                    .of(context)
                    .textTheme
                    .title,
              ),
              onPressed: () {
                _showDatePicker();
              },
            ),
            Padding(
              child: FlatButton(
                onPressed: () {
                  _fireStoreAdd();
                },
                color: Color.fromRGBO(170, 103, 167, 1.0),
                child: Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Padding(
                      child: Text('SUBMIT', style:
                      TextStyle(
                          fontSize: 20.0
                      ),),

                      padding: EdgeInsets.only(left: 40.0, right: 40.0),)
                ),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                textColor: Colors.white,
              ), padding: EdgeInsets.only(bottom: 50.0),),
            Padding(padding: EdgeInsets.only(bottom: 10.0),
                child: Image(image: AssetImage('images/slogan_color.png'),))

          ],
        ),
      );
    }
  }
}
