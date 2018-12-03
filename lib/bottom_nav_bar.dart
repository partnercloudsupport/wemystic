import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wemystic/astrology/astrology_birth_chart.dart';
import 'package:wemystic/astrology/astrology_chinese_horoscope.dart';
import 'package:wemystic/astrology/astrology_header.dart';
import 'package:wemystic/astrology/astrology_horoscope.dart';
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
  AstrologyHoroscope astrology;
  AstrologyChineseHoroscope chineseHoroscope;
  AstrologyBirthChart birthChart;
  List<Widget> pages;
  Widget currentPage;

  @override
  void initState(){
    astrology = AstrologyHoroscope()  ;
    home = WeMysticNewsData();
    chineseHoroscope = AstrologyChineseHoroscope();
    birthChart = AstrologyBirthChart();

    pages = [home, chineseHoroscope, astrology, birthChart];

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
            onTap: (int index){
              setState(() {
                currentTab = index;
                currentPage = pages[index];

              });
            },
            items: <BottomNavigationBarItem>[
              new BottomNavigationBarItem(
                icon: Image(image: AssetImage('images/icon_nav_home.png'), color: Colors.white,),
                title: new Text('Home'),
                backgroundColor:  Color.fromRGBO(36,	153,	220, 1.0),
              ),
              new BottomNavigationBarItem(
                icon: Image(image: AssetImage('images/icon_nav_account.png'),
                color: Colors.white,),
                title: new Text('Profile'),
                backgroundColor:  Color.fromRGBO(36,	153,	220, 1.0),
              ),
              new BottomNavigationBarItem(
                icon: Image(image: AssetImage('images/icon_nav_astrology.png'), color: Colors.white,),
                title: new Text('Astrology'),
                backgroundColor:  Color.fromRGBO(36,	153,	220, 1.0),
              ),
              new BottomNavigationBarItem(
                icon: Image(image: AssetImage('images/icon_nav_birthchart.png'),
                color: Colors.white,),
                title: new Text('Birth Chart', style: TextStyle(
                  color: Colors.white
                ),),
                backgroundColor:  Color.fromRGBO(36,	153,	220, 1.0)
              ),
            ]));
  }

}
