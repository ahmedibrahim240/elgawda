import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/secreens/home/home.dart';
import 'package:elgawda/secreens/more/more.dart';
import 'package:elgawda/secreens/my%20courses/mycourses.dart';
import 'package:elgawda/secreens/wishlist/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Home(),
    MyCourses(),
    Wishlist(),
    More(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: customColorDivider,
        selectedItemColor: customColor,
        unselectedItemColor: customColor.withOpacity(.60),
        selectedLabelStyle: AppTheme.headingColorBlue,
        unselectedLabelStyle: AppTheme.subHeadingColorBlue,
        onTap: (value) {
          setState(() => _currentIndex = value);
        },
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'My Courses',
            icon: Icon(
              FontAwesomeIcons.youtube,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Wishlist',
            icon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            label: 'More',
            icon: Icon(Icons.more_horiz),
          ),
        ],
      ),
    );
  }
}
