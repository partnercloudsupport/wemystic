import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
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

class _GridTitleText extends StatelessWidget {
  const _GridTitleText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Text(text),
    );
  }
}

class GridDemoPhotoItem extends StatelessWidget {
  GridDemoPhotoItem({Key key, @required this.photo, @required this.onBannerTap})
      : assert(photo != null && photo.isValid),
        assert(onBannerTap != null),
        super(key: key);

  final Photo photo;
  final BannerTapCallback
      onBannerTap; // User taps on the photo's header or footer.

  void showPhoto(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute<void>(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text(photo.title)),
        body: SizedBox.expand(),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    final Widget image = GestureDetector(
        onTap: () {
          showPhoto(context);
        },
        child: Hero(
            key: Key(photo.assetUrl),
            tag: photo.tag,
            child: Image.network(
              photo.assetUrl,
              fit: BoxFit.fill,
            )));

    final IconData icon = photo.isFavorite ? Icons.star : Icons.star_border;
    return GridTile(
      header: GestureDetector(
        onTap: () {
          onBannerTap(photo);
        },
        child: GridTileBar(
          title: _GridTitleText(photo.title),
          backgroundColor: Colors.black45,
          leading: Icon(
            icon,
            color: Colors.white,
          ),
        ),
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
  final String url =
      "https://api.rss2json.com/v1/api.json?rss_url=https://www.wemystic.com/feed-horoscope-daily&api_key=e31qew7ogvak9hrtfybkk9kcelycciijergbhffj&count=12";

  List data;

  Future<String> getWMNews() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      var resBody = json.decode(res.body);
      data = resBody["items"];
    });
    return "Success!";
  }

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
      assetUrl:
          'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-peixes.png',
      title: 'Pisces',
      isFavorite: false,
    ),
    Photo(
      assetUrl:
          'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-aquario.png',
      title: 'Aquarius',
      isFavorite: false,
    ),
    Photo(
      assetUrl:
          'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-capricornio.png',
      title: 'Capricorn',
      isFavorite: false,
    ),
    Photo(
      assetUrl:
          'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-sagitario.png',
      title: 'Sagittarius',
      isFavorite: false,
    ),
    Photo(
      assetUrl:
          'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-escorpiao.png',
      title: 'Scorpio',
      isFavorite: false,
    ),
    Photo(
      assetUrl:
          'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-libra.png',
      title: 'Libra',
      isFavorite: false,
    ),
    Photo(
      assetUrl:
          'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-virgem.png',
      title: 'Virgo',
      isFavorite: false,
    ),
    Photo(
      assetUrl:
          'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-leao.png',
      title: 'Leo',
      isFavorite: false,
    ),
    Photo(
      assetUrl:
          'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-caranguejo.png',
      title: 'Cancer',
      isFavorite: false,
    ),
    Photo(
      assetUrl:
          'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-gemeos.png',
      title: 'Gemini',
      isFavorite: false,
    ),
    Photo(
      assetUrl:
          'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-touro.png',
      title: 'Taurus',
      isFavorite: false,
    ),
    Photo(
      assetUrl:
          'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-aries.png',
      title: 'Aries',
      isFavorite: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grid list'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SafeArea(
              top: false,
              bottom: false,
              child: GridView.count(
                crossAxisCount: (orientation == Orientation.portrait) ? 3 : 4,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                padding: const EdgeInsets.all(4.0),
                childAspectRatio:
                    (orientation == Orientation.portrait) ? 1.0 : 1.3,
                children: photos.map<Widget>((Photo photo) {
                  return Container(
                      color: Color.fromRGBO(128, 112, 157, 1),
                      child: GridDemoPhotoItem(
                          photo: photo,
                          onBannerTap: (Photo photo) {
                            setState(() {
                              photo.isFavorite = !photo.isFavorite;
                            });
                          }));
                }).toList(),
              ),
            ),
          ),
          RaisedButton(
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
            child: Text('Submit'),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    this.getWMNews();
    this._fireStoreFetch();
  }
}
