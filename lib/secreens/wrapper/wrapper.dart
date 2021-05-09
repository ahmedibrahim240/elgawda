import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/localization/localization_constants.dart';
import 'package:elgawda/models/userData.dart';
import 'package:elgawda/models/utils.dart';
import 'package:elgawda/secreens/cart/cart.dart';
import 'package:elgawda/secreens/home/home.dart';
import 'package:elgawda/secreens/more/more.dart';
import 'package:elgawda/secreens/my%20courses/mycourses.dart';
import 'package:elgawda/secreens/wishlist/wishlist.dart';
import 'package:elgawda/services/network_sensitive.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../sharedPreferences.dart';

class Wrapper extends StatefulWidget {
  static final route = '/Wrapper';

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  int _currentIndex = 0;
  final List<Widget> _children = [
    NetworkSensitive(child: Home()),
    NetworkSensitive(child: MyCourses()),
    NetworkSensitive(child: Wishlist()),
    NetworkSensitive(child: More()),
  ];
  getDateOfUser() async {
    User.userPassword = await MySharedPreferences.getUserUserPassword();
    User.userToken = await MySharedPreferences.getUserUserToken();
    User.appLang = await MySharedPreferences.getAppLang();
    Cart.totalPraices = await MySharedPreferences.getTotalPrice();
  }

  @override
  void initState() {
    getDateOfUser();
    gitFCMToken();
    super.initState();
    print('UserToken:' + User.userToken.toString());
  }

  gitFCMToken() {
    try {
      _fcm.getToken().then(
        (token) {
          print('FCM Token:$token');

          updateFcmToken(token);
        },
      );
    } catch (e) {
      print('FCM EROOOR');
      print(e);
    }
  }

  updateFcmToken(var token) async {
    try {
      var response = await http.put(Utils.Update_fcm_URL + '$token', headers: {
        'x-api-key': User.userToken.toString(),
      });
      var jsonData = json.decode(response.body);
      print(jsonData);
    } catch (e) {
      print('Cash updateFcmToken');
      print(e);
    }
  }

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
