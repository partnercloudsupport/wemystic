import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wemystic/login_page.dart';

typedef BannerTapCallback = void Function(Photo photo);

class Photo {
  Photo({
    this.assetUrl,
    this.title,
    this.isFavorite,
  });

  final String assetUrl;
  String title;

  bool isFavorite;

  String get tag => assetUrl; // Assuming that all asset names are unique.

  bool get isValid => assetUrl != null && title != null;
}

class GridDemoPhotoItem extends StatelessWidget {
  GridDemoPhotoItem({Key key, @required this.photo, @required this.onBannerTap})
      : assert(photo != null && photo.isValid),
        assert(onBannerTap != null),
        super(key: key);

  final Photo photo;
  final BannerTapCallback
  onBannerTap; // User taps on the photo's header or footer.

  @override
  Widget build(BuildContext context) {
    final Widget image = GestureDetector(
        onTap: () {
          onBannerTap(photo);
        },
        child: Hero(
            tag: photo.tag,
            child: photo.isFavorite
                ? Padding(
                padding: EdgeInsets.all(10.0),
                child: Image(
                  image: AssetImage(
                    photo.assetUrl,
                  ),
                ))
                : Padding(
                padding: EdgeInsets.all(10.0),
                child: Opacity(
                    opacity: 0.5,
                    child: Image(
                      image: AssetImage(
                        photo.assetUrl,
                      ),
                    )))));

    final Image icon = photo.isFavorite
        ? Image(
      image: AssetImage('images/icon_check.png'),
      width: 20.0,
    )
        : null;
    return GridTile(
      footer: GestureDetector(
        onTap: () {
          onBannerTap(photo);
        },
        child: Center(child: icon),
      ),
      child: image,
    );
  }
}

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String myZodiacSign;
  String myChineseSign;
  String myBirthDate;
  FirebaseUser user;
  String zodiacSign;
  String chineseSign;
  String chineseSignElement;
  bool _loadingInProgress;
  String _datetime = '';
  int _year = DateTime
      .now()
      .year;
  int _month = DateTime
      .now()
      .month;
  int _date = DateTime
      .now()
      .day;
  String _lang = 'en';
  String _format = 'dd-mm-yyyy';
  bool _showTitleActions = true;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();

  Future<Null> signOutWithGoogle() async {
    // Sign out with firebase
    await _auth.signOut();
    // Sign out with google
    await _googleSignIn.signOut();
  }

  TextEditingController _langCtrl = TextEditingController();
  TextEditingController _formatCtrl = TextEditingController();

  _fireStoreFetch() async {
    user = await FirebaseAuth.instance.currentUser();
    final DocumentReference docRef = Firestore.instance
        .collection("profile")
        .document("${user.uid.toString()}");
    docRef.get().then((dataSnapshot) {
      photos[0].isFavorite = dataSnapshot.data['pisces'];
      photos[1].isFavorite = dataSnapshot.data['aquarius'];
      photos[2].isFavorite = dataSnapshot.data['capricorn'];
      photos[3].isFavorite = dataSnapshot.data['sagittarius'];
      photos[4].isFavorite = dataSnapshot.data['scorpio'];
      photos[5].isFavorite = dataSnapshot.data['libra'];
      photos[6].isFavorite = dataSnapshot.data['virgo'];
      photos[7].isFavorite = dataSnapshot.data['leo'];
      photos[8].isFavorite = dataSnapshot.data['cancer'];
      photos[9].isFavorite = dataSnapshot.data['gemini'];
      photos[10].isFavorite = dataSnapshot.data['taurus'];
      photos[11].isFavorite = dataSnapshot.data['aries'];
      myBirthDate = dataSnapshot.data['birth_date'];
      myChineseSign = dataSnapshot.data['chinese_sign'];
      myZodiacSign = dataSnapshot.data['zodiac_sign'];
    });
  }

  @override
  void initState() {
    this._fireStoreFetch();
    super.initState();
    _langCtrl.text = 'en';
    _formatCtrl.text = 'dd-mm-yyyy';

    DateTime now = DateTime.now();
    _year = now.year;
    _month = now.month;
    _date = now.day;
    _loadingInProgress = true;
    _loadData();
  }

  _fireStoreEditProfile() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final DocumentReference docRef = Firestore.instance
        .collection("profile")
        .document("${user.uid.toString()}");
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
    Map<String, bool> data = <String, bool>{
      "pisces": photos[0].isFavorite,
      "aquarius": photos[1].isFavorite,
      "capricorn": photos[2].isFavorite,
      "sagittarius": photos[3].isFavorite,
      "scorpio": photos[4].isFavorite,
      "libra": photos[5].isFavorite,
      "virgo": photos[6].isFavorite,
      "leo": photos[7].isFavorite,
      "cancer": photos[8].isFavorite,
      "gemini": photos[9].isFavorite,
      "taurus": photos[10].isFavorite,
      "aries": photos[11].isFavorite,
    };
    Map<String, String> dataString = <String, String>{
      "birth_date": _datetime,
      "zodiac_sign": zodiacSign,
      "chinese_sign": '$chineseSign $chineseSignElement',
    };
    docRef.setData(data, merge: true).whenComplete(() {
      print("Document added");
    }).catchError((e) => print(e));
    docRef.setData(dataString, merge: true);
  }

  /// Display date picker.
  void _showDatePicker() {
    final bool showTitleActions = false;
    DatePicker.showDatePicker(
      context,
      showTitleActions: _showTitleActions,
      minYear: 1970,
      maxYear: DateTime
          .now()
          .year,
      initialYear: _year,
      initialMonth: _month,
      initialDate: _date,
      confirm: Text(
        'Confirm',
        style: TextStyle(color: Colors.red),
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

  Future _loadData() async {
    await new Future.delayed(new Duration(seconds: 2));
    _dataLoaded();
  }

  void _dataLoaded() {
    setState(() {
      _loadingInProgress = false;
    });
  }

  List<Photo> photos = <Photo>[
    Photo(
      assetUrl: 'images/zodiac/icon_zodiac_color_pisces.png',
      title: 'Pisces',
    ),
    Photo(
      assetUrl: 'images/zodiac/icon_zodiac_color_aquarius.png',
      title: 'Aquarius',
      isFavorite: false,
    ),
    Photo(
      assetUrl: 'images/zodiac/icon_zodiac_color_capricorn.png',
      title: 'Capricorn',
      isFavorite: false,
    ),
    Photo(
      assetUrl: 'images/zodiac/icon_zodiac_color_sagittarius.png',
      title: 'Sagittarius',
      isFavorite: false,
    ),
    Photo(
      assetUrl: 'images/zodiac/icon_zodiac_color_scorpio.png',
      title: 'Scorpio',
      isFavorite: false,
    ),
    Photo(
      assetUrl: 'images/zodiac/icon_zodiac_color_libra.png',
      title: 'Libra',
      isFavorite: false,
    ),
    Photo(
      assetUrl: 'images/zodiac/icon_zodiac_color_virgo.png',
      title: 'Virgo',
      isFavorite: false,
    ),
    Photo(
      assetUrl: 'images/zodiac/icon_zodiac_color_leo.png',
      title: 'Leo',
      isFavorite: false,
    ),
    Photo(
      assetUrl: 'images/zodiac/icon_zodiac_color_cancer.png',
      title: 'Cancer',
      isFavorite: false,
    ),
    Photo(
      assetUrl: 'images/zodiac/icon_zodiac_color_gemini.png',
      title: 'Gemini',
      isFavorite: false,
    ),
    Photo(
      assetUrl: 'images/zodiac/icon_zodiac_color_taurus.png',
      title: 'Taurus',
      isFavorite: false,
    ),
    Photo(
      assetUrl: 'images/zodiac/icon_zodiac_color_aries.png',
      title: 'Aries',
    ),
  ];

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Saved"),
          content: new Text("Your account settings are saved!"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
    } else {
      final Orientation orientation = MediaQuery
          .of(context)
          .orientation;
      return Scaffold(
          appBar: AppBar(
            title: Text(
              "Profile",
              style: TextStyle(fontFamily: 'Dosis'),
            ),
            backgroundColor: Color.fromRGBO(56, 107, 169, 1.0),
            elevation: 0.0,
            automaticallyImplyLeading: false,
          ),
          body: Container(
            color: Color.fromRGBO(237, 239, 240, 1.0),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Container(
                  width: 24.0,
                  height: 24.0,
                  child: Image.network(
                    '${user.photoUrl}',
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Text('Hello ${user.displayName}'),
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Photo().title == myZodiacSign
                            ? Image(image: AssetImage('${Photo().assetUrl}')) :
                        Container(),
                        Text(myZodiacSign)
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(myChineseSign)
                      ],
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('Birth Date : '),
                    FlatButton(
                      padding: EdgeInsets.only(left: 12.0),
                      child: _datetime == ''
                          ? Row(children: <Widget>[
                        Text(
                          myBirthDate,
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Color.fromRGBO(159, 160, 162, 1.0),
                              fontFamily: 'Dosis'),
                        ),
                        Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(Icons.edit))
                      ])
                          : Row(
                        children: <Widget>[
                          Text(
                            '$_datetime',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Color.fromRGBO(159, 160, 162, 1.0),
                                fontFamily: 'Dosis'),
                          ),
                          Icon(Icons.edit)
                        ],
                      ),
                      onPressed: () {
                        _showDatePicker();
                      },
                    ),
                  ],
                ),
                Text('Manage your favorite Signs:'),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      SafeArea(
                        top: false,
                        bottom: false,
                        child: Container(
                            height: 280.0,
                            child: GridView.count(
                              crossAxisCount:
                              (orientation == Orientation.portrait) ? 4 : 3,
                              mainAxisSpacing: 2.0,
                              crossAxisSpacing: 2.0,
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
                              childAspectRatio:
                              (orientation == Orientation.portrait)
                                  ? 1.0
                                  : 1.3,
                              children: photos.map<Widget>((Photo photo) {
                                return Container(
                                    child: GridDemoPhotoItem(
                                        photo: photo,
                                        onBannerTap: (Photo photo) {
                                          setState(() {
                                            photo.isFavorite =
                                            !photo.isFavorite;
                                          });
                                        }));
                              }).toList(),
                            )),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: 35.0, left: 35.0, bottom: 15.0),
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        _fireStoreFetch();
                      });
                      _fireStoreEditProfile();
                      _showDialog();
                    },
                    color: Color.fromRGBO(170, 103, 167, 1.0),
                    child: Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Padding(
                          child: Text(
                            'SUBMIT',
                            style:
                            TextStyle(fontSize: 20.0, fontFamily: 'Dosis'),
                          ),
                          padding: EdgeInsets.only(left: 40.0, right: 40.0),
                        )),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    textColor: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 35.0, right: 35.0, bottom: 10.0),
                  child: FlatButton(
                    onPressed: () {
                      signOutWithGoogle().then((Null) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                            new LoginPage()));
                      });
                    },
                    color: Colors.red,
                    child: Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Padding(
                          child: Text(
                            'LOG OUT',
                            style:
                            TextStyle(fontSize: 20.0, fontFamily: 'Dosis'),
                          ),
                          padding: EdgeInsets.only(left: 40.0, right: 40.0),
                        )),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    textColor: Colors.white,
                  ),
                )
              ],
            ),
          ));
    }
  }
}
