import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wemystic/bottom_nav_bar.dart';

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

class GridListDemo extends StatefulWidget {
  final FirebaseUser user;

  const GridListDemo({Key key, this.user}) : super(key: key);

  @override
  GridListDemoState createState() => GridListDemoState();
}

class GridListDemoState extends State<GridListDemo> {
  FirebaseUser user;
  var list;
  var random;
  static bool favorite;

  bool isFavorite;

  _fireStoreFetch() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final DocumentReference docRef = Firestore.instance
        .collection("profile")
        .document("${user.uid.toString()}");
    docRef.get().then((dataSnapshot) {
      isFavorite = dataSnapshot.data["pisces"];
      if (dataSnapshot.data["aries"] != null) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => HomePage(
                  user: user,
                )));
      }
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.fromLTRB(0.0, 200.0, 0.0, 0.0),
                child: Image(
                  image: AssetImage('images/logo_white.png'), width: 170.0,
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 50.0),
                child: Image(
                  image: AssetImage('images/slogan_white.png'), width: 170.0,
                ))
          ],
        ),
      );
    } else {
      final Orientation orientation = MediaQuery.of(context).orientation;
      return new Container(
          color: Color.fromRGBO(237, 239, 240, 1.0),
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 70.0)),
              Image(
                image: AssetImage('images/logo_color.png'), width: 170.0,
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  'Pick your favorites signs.',
                  style: TextStyle(
                    color: Color.fromRGBO(102, 103, 104, 1.0),
                    fontSize: 14.0,
                    fontFamily: 'Roboto'
                  ),
                ),
              ),
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
              Padding(
              child: FlatButton(
                onPressed: () async {
                  FirebaseUser user = await FirebaseAuth.instance.currentUser();
                  final DocumentReference docRef = Firestore.instance
                      .collection("profile")
                      .document("${user.uid.toString()}");

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
                  docRef.setData(data, merge: true).whenComplete(() {
                    print("Document added");
                  }).catchError((e) => print(e));
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => HomePage(
                            user: user,
                          )));
                },
                color: Color.fromRGBO(170, 103, 167, 1.0),
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child:Padding(
                    child: Text('SUBMIT', style:
                      TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Dosis'
                      ),),

                    padding: EdgeInsets.only(left: 40.0, right: 40.0),)
                ),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                textColor: Colors.white,
              ), padding: EdgeInsets.only(bottom: 50.0),),
              Padding(padding: EdgeInsets.only(bottom: 30.0),
              child: Image(image: AssetImage('images/slogan_color.png'), width: 170.0,))
            ],
          ));
    }
  }

  bool _loadingInProgress;

  @override
  void initState() {
    super.initState();
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
}
