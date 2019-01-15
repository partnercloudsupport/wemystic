import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wemystic/astrology/astrology.dart';
import 'package:wemystic/astrology/astrology_birth_chart.dart';
import 'package:wemystic/mlkit/mlkit_page.dart';
import 'package:wemystic/profile.dart';
import 'package:wemystic/we_mystic_news.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class HomePage extends StatefulWidget {
  static final String route = "home-page";
  final FirebaseUser user;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  HomePage({this.user, this.analytics, this.observer});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTab = 0;
  WeMysticNewsData home;
  AstrologyHeader astrology;
  AstrologyBirthChart birthChart;
  Profile profile;
  MLKitPage mlKitPage;
  List<Widget> pages;
  Widget currentPage;

  @override
  void initState() {
    astrology = AstrologyHeader();
    home = WeMysticNewsData();
    birthChart = AstrologyBirthChart();
    profile = Profile();
    mlKitPage = MLKitPage();

    pages = [home, profile, astrology, birthChart, mlKitPage];

    currentPage = home;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: currentPage,
        bottomNavigationBar: new BottomNavigationBar(
            currentIndex: currentTab,
            iconSize: 12.0,
            onTap: (int index) {
              setState(() {
                currentTab = index;
                currentPage = pages[index];
              });
            },
            items: <BottomNavigationBarItem>[
              new BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage('images/icon_nav_home.png'),
                  color: Colors.white,
                  width: 50.0,
                ),
                title: new Text('Home', style: TextStyle(fontFamily: 'Dosis')),
                backgroundColor: Color.fromRGBO(36, 153, 220, 1.0),
              ),
              new BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage('images/icon_nav_account.png'),
                  color: Colors.white,
                  width: 50.0,
                ),
                title:
                    new Text('Profile', style: TextStyle(fontFamily: 'Dosis')),
                backgroundColor: Color.fromRGBO(36, 153, 220, 1.0),
              ),
              new BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage('images/icon_nav_astrology.png'),
                  color: Colors.white,
                  width: 50.0,
                ),
                title: new Text('Astrology',
                    style: TextStyle(fontFamily: 'Dosis')),
                backgroundColor: Color.fromRGBO(36, 153, 220, 1.0),
              ),
              new BottomNavigationBarItem(
                  icon: Image(
                    image: AssetImage('images/icon_nav_birthchart.png'),
                    color: Colors.white,
                    width: 50.0,
                  ),
                  title: new Text(
                    'Birth Chart',
                    style: TextStyle(fontFamily: 'Dosis'),
                  ),
                  backgroundColor: Color.fromRGBO(36, 153, 220, 1.0)),
              new BottomNavigationBarItem(
                  icon: Icon(
                    Icons.pan_tool,
                    color: Colors.white,
                    size: 25.0,
                  ),
                  title: new Text(
                    'MLKIT',
                    style: TextStyle(fontFamily: 'Dosis'),
                  ),
                  backgroundColor: Color.fromRGBO(36, 153, 220, 1.0)),
            ]));
  }
}
