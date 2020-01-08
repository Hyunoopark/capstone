import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'login.dart';
import 'userinfo.dart';
import 'profile.dart';

class NavigatePage extends StatefulWidget {
  UserDetails userDetails;
  NavigatePage({Key key, @required this.userDetails}) : super(key: key);

  @override
  _NavigateState createState() => _NavigateState();
}

class _NavigateState extends State<NavigatePage> {
  int _selectedPage = 0;
  final _pageOptions = [
    HomePage(),
    ProfilePage(),
  ];


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigate',
      color: Color(0xFF151561),
      home: Scaffold(
        body: _pageOptions[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          //4개 이상의 아이템을 넣을 때 고정
          type: BottomNavigationBarType.fixed,
          //아이템의 타이틀을 없애기
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _selectedPage,
          onTap: (int index) {
            setState(() {
              _selectedPage = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30,),
              title: Text('home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 30),
              title: Text('Profile'),
            ),
          ],
          selectedItemColor: Color(0xFF151561),
        ),
      ),
    );
  }
}
