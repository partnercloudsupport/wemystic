
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


typedef BannerTapCallback = void Function(Photo photo);


class Photo{

  Photo({
    this.assetUrl,

    this.title,
    this.isFavorite = false,
  });
  final String assetUrl;
  final String title;

  bool isFavorite;
  String get tag => assetUrl; // Assuming that all asset names are unique.

  bool get isValid => assetUrl != null && title != null && isFavorite != null;
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
  GridDemoPhotoItem({
    Key key,
    @required this.photo,
    @required this.onBannerTap
  }) : assert(photo != null && photo.isValid),
        assert(onBannerTap != null),
        super(key: key);

  final Photo photo;
  final BannerTapCallback onBannerTap; // User taps on the photo's header or footer.

  void showPhoto(BuildContext context) {
    Navigator.push(context, MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
                title: Text(photo.title)
            ),
            body: SizedBox.expand(

            ),
          );
        }
    ));
  }

  @override
  Widget build(BuildContext context) {
    final Widget image = GestureDetector(
        onTap: () { showPhoto(context); },
        child: Hero(
            key: Key(photo.assetUrl),
            tag: photo.tag,
            child: Image.network(
              photo.assetUrl,
              fit: BoxFit.fill,
            )
        )
    );

    final IconData icon = photo.isFavorite ? Icons.star : Icons.star_border;
    return GridTile(
      header: GestureDetector(
        onTap: () { onBannerTap(photo); },
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


  const GridListDemo({ Key key , this.user}) : super(key: key);

  static const String routeName = '/material/grid-list';

  @override
  GridListDemoState createState() => GridListDemoState();
}

class GridListDemoState extends State<GridListDemo> {


  var list;
  var random;

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


  List<Photo> photos = <Photo>[

    Photo(
      assetUrl: 'https://assets.wemystic.com/wmcom/2018/04/daily-horoscope-pisces.jpg',
      title: 'Pisces',
    ),
    Photo(
      assetUrl: 'https://mkt.wemystic.com/design/icons/zodiac/circle/wm-icon-zodiac-aquario.png',
      title: 'Aquarius',
    ),
    Photo(
      assetUrl: 'https://assets.wemystic.com/wmcom/2018/04/daily-horoscope-capricorn.jpg',
      title: 'Capricorn',
    ),
    Photo(
      assetUrl: 'https://assets.wemystic.com/wmcom/2018/04/daily-horoscope-sagittarius.jpg',
      title: 'Sagittaius',
    ),
    Photo(
      assetUrl: 'https://assets.wemystic.com/wmcom/2018/04/daily-horoscope-scorpio.jpg',
      title: 'Scorpio',
    ),
    Photo(
      assetUrl: 'https://assets.wemystic.com/wmcom/2018/04/daily-horoscope-libra.jpg',
      title: 'Libra',
    ),
    Photo(
      assetUrl: 'https://assets.wemystic.com/wmcom/2018/04/daily-horoscope-virgo.jpg',
      title: 'Virgo',
    ),
    Photo(
      assetUrl: 'https://assets.wemystic.com/wmcom/2018/04/daily-horoscope-leo.jpg',
      title: 'Leo',
    ),
    Photo(
      assetUrl: 'https://assets.wemystic.com/wmcom/2018/04/daily-horoscope-cancer.jpg',
      title: 'Cancer',
    ),
    Photo(
      assetUrl: 'https://assets.wemystic.com/wmcom/2018/04/daily-horoscope-gemini.jpg',
      title: 'Gemini',
    ),
    Photo(
      assetUrl: 'https://assets.wemystic.com/wmcom/2018/04/daily-horoscope-taurus.jpg',
      title: 'Taurus',
    ),
    Photo(
      assetUrl: 'https://assets.wemystic.com/wmcom/2018/04/daily-horoscope-aries.jpg',
      title: 'Aries',
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
                crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,

                padding: const EdgeInsets.all(4.0),
                childAspectRatio: (orientation == Orientation.portrait) ? 1.0 : 1.3,
                children: photos.map<Widget>((Photo photo) {
                  return GridDemoPhotoItem(
                      photo: photo,
                      onBannerTap: (Photo photo) {
                        setState(() {
                          photo.isFavorite = !photo.isFavorite;
                        });
                      }
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    this.getWMNews();
  }
}
