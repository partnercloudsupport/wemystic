import 'package:flutter/material.dart';
import 'package:wemystic/astrology/astrology_birth_chart.dart';
import 'package:wemystic/astrology/astrology_horoscope.dart';
import 'package:wemystic/astrology/astrology_moon.dart';


class AstrologyTabs extends StatefulWidget {
  @override
  _AstrologyTabsState createState() => _AstrologyTabsState();
}

class _AstrologyTabsState extends State<AstrologyTabs>
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
    return Scaffold(
      body: NestedScrollView(
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
                    text: "Horoscope",
                  ),
                  Tab(
                    text: "Chinese Horoscope",
                  ),
                  Tab(
                    text: "Birth Chart",
                  ),
                  Tab(
                    text: "Moon",
                  ),
                ],
                controller: _tabController,
              ),
            )
          ];
        },
        body: TabBarView(
          children: <Widget>[
            AstrologyHoroscope(),
            //AstrologyChineseHoroscope(),
            AstrologyBirthChart(),
            AstrologyMoon(),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}