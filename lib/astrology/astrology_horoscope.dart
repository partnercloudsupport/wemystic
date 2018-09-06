import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wemystic/astrology/horoscope/characteristics_horoscope.dart';
import 'package:wemystic/astrology/horoscope/month_horoscope.dart';
import 'package:wemystic/astrology/horoscope/today_horoscope.dart';
import 'package:wemystic/astrology/horoscope/week_horoscope.dart';
import 'package:wemystic/astrology/horoscope/year_horoscope.dart';

class AstrologyHoroscope extends StatefulWidget {
  final FirebaseUser user;

  AstrologyHoroscope({this.user});

  _AstrologyHoroscopeState createState() => _AstrologyHoroscopeState();
}

class _AstrologyHoroscopeState extends State<AstrologyHoroscope>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Row(children: <Widget>[
      Text('Pisces'),
      Row(children: <Widget>[
        new TabBar(
          isScrollable: true,
          tabs: <Widget>[
            Tab(
              text: "Today",
            ),
            Tab(
              text: "Week",
            ),
            Tab(
              text: "Month",
            ),
            Tab(
              text: "Year",
            ),
            Tab(
              text: "Characteristics",
            ),
          ],
          controller: _tabController,
        ),
      ]),
      Row(children: <Widget>[
        TabBarView(
          children: <Widget>[
            TodayHoroscope(),
            WeekHoroscope(),
            MonthHoroscope(),
            YearHoroscope(),
            CharacteristicsHoroscope(),
          ],
          controller: _tabController,
        ),
      ])
    ])));
  }
}
