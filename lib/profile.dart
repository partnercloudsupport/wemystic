import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';


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
                ? Padding( padding: EdgeInsets.all(10.0),child: Image(
              image: AssetImage(
                photo.assetUrl,
              ),
            ))
                :  Padding(padding: EdgeInsets.all(10.0), child: Opacity(
                opacity: 0.5,
                child: Image(
                  image: AssetImage(
                    photo.assetUrl,
                  ),
                )))));

    final Image icon = photo.isFavorite
        ? Image(
      image: AssetImage('images/icon_check.png'),width: 20.0,
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
  FirebaseUser user;
  bool _loadingInProgress;
  String _datetime = '';
  int _year = DateTime.now().year;
  int _month = DateTime.now().month;
  int _date = DateTime.now().day;
  String _lang = 'en';
  String _format = 'dd-mm-yyyy';
  bool _showTitleActions = true;

  TextEditingController _langCtrl = TextEditingController();
  TextEditingController _formatCtrl = TextEditingController();

  _fireStoreFetch() async {
    user = await FirebaseAuth.instance.currentUser();
    final DocumentReference docRef = Firestore.instance
        .collection("profile")
        .document("${user.uid.toString()}");
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
      isFavorite: false,
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
      isFavorite: false,
    ),
  ];
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
      final Orientation orientation = MediaQuery.of(context).orientation;
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('Hello ${user.displayName}'),
                Row(
                  children: <Widget>[
                    Text('Birth Date : '),
                    FlatButton(
                      padding: EdgeInsets.only(left: 12.0),
                      child: _datetime == ''
                          ? Text(
                              'DD / MM / YYYY',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Color.fromRGBO(159, 160, 162, 1.0),
                                  fontFamily: 'Dosis'),
                            )
                          : Text(
                              '$_datetime',
                              style: Theme.of(context).textTheme.title,
                            ),
                      onPressed: () {
                        _showDatePicker();
                      },
                    ),
                  ],
                ),
                Text('Manage your favorite Signs:'),
                Expanded(
                  child: SafeArea(
                    top: true,
                    bottom: true,
                    child: GridView.count(
                      crossAxisCount: (orientation == Orientation.portrait) ? 4 : 3,
                      mainAxisSpacing: 2.0,
                      crossAxisSpacing: 2.0,
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      childAspectRatio:
                      (orientation == Orientation.portrait) ? 1.0 : 1.3,
                      children: photos.map<Widget>((Photo photo) {
                        return Container(
                            child: GridDemoPhotoItem(
                                photo: photo,
                                onBannerTap: (Photo photo) {
                                  setState(() {
                                    photo.isFavorite = !photo.isFavorite;
                                  });
                                }));
                      }).toList(),
                    ),
                  ),),
              ],
            ),
          ));
    }
  }
}
