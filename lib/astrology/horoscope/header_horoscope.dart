import 'package:flutter/material.dart';
import 'package:wemystic/astrology/horoscope/characteristics_horoscope.dart';
import 'package:wemystic/astrology/horoscope/detail_horoscope.dart';
import 'package:wemystic/astrology/horoscope/month_horoscope.dart';
import 'package:wemystic/astrology/horoscope/today_horoscope.dart';
import 'package:wemystic/astrology/horoscope/week_horoscope.dart';
import 'package:wemystic/astrology/horoscope/year_horoscope.dart';


class HoroscopeTabs extends StatefulWidget {
  @override
  _HoroscopeTabsState createState() => _HoroscopeTabsState();
}

class _HoroscopeTabsState extends State<HoroscopeTabs>
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
       child: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text('Tab Controller Example'),
              automaticallyImplyLeading: false,
              pinned: true,
              floating: true,
              forceElevated: boxIsScrolled,
              bottom: TabBar(
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
                  )
                ],
                controller: _tabController,
              ),
            )
          ];
        },
        body: TabBarView(
          children: <Widget>[
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}