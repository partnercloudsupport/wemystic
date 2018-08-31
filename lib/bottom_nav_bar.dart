import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wemystic/astrology/astrology_header.dart';
import 'package:wemystic/we_mystic_news.dart';

class HomePage extends StatefulWidget {
  static final String route = "home-page";
  final FirebaseUser user;
  HomePage({this.user});

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  int currentTab = 0;
  WeMysticNewsData home;
  AstrologyTabs astrology;
  List<Widget> pages;
  Widget currentPage;

  @override
  void initState(){
    astrology = AstrologyTabs();
    home = WeMysticNewsData();

    pages = [home, astrology];

    currentPage = home;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: currentPage,

        bottomNavigationBar: new BottomNavigationBar(
            currentIndex: currentTab,
            onTap: (int index){
              setState(() {
                currentTab = index;
                currentPage = pages[index];
              });
            },
            items: <BottomNavigationBarItem>[
              new BottomNavigationBarItem(
                icon: const Icon(
                  Icons.home,
                ),
                title: new Text('Home'),
              ),

              new BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                title: new Text("${widget.user.uid}"),
              ),
            ]));
  }

}
