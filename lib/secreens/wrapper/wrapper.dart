import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/localization/localization_constants.dart';
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
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Color(0xfffF1F1F1),
        selectedItemColor: customColor,
        unselectedItemColor: customColor.withOpacity(.60),
        selectedLabelStyle: AppTheme.headingColorBlue,
        unselectedLabelStyle: AppTheme.subHeadingColorBlue,
        onTap: (value) {
          setState(() => _currentIndex = value);
        },
        items: [
          BottomNavigationBarItem(
            label: getTranslated(context, 'home'),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: getTranslated(context, 'my_courses'),
            icon: Icon(
              FontAwesomeIcons.youtube,
            ),
          ),
          BottomNavigationBarItem(
            label: getTranslated(context, 'wishlist'),
            icon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            label: getTranslated(context, 'more'),
            icon: Icon(Icons.more_horiz),
          ),
        ],
      ),
    );
  }
}
