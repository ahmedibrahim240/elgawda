import 'dart:async';

import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/models/userData.dart';
import 'package:elgawda/services/network_sensitive.dart';

import 'package:flutter/material.dart';

import '../sharedPreferences.dart';
import 'onboarding/onboarding.dart';

class SplashScreen extends StatefulWidget {
  static final route = '/splashScreen';

  static bool slider = true;
  static void isSlider() {
    slider = !slider;
  }

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  getDateOfUser() async {
    User.userToken = await MySharedPreferences.getUserUserToken() ?? 'null';
    User.userLogIn = await MySharedPreferences.getUserSingIn();
    User.appLang = await MySharedPreferences.getAppLang();
    User.userSkipLogIn = await MySharedPreferences.getUserSkipLogIn();
  }

  @override
  void initState() {
    getDateOfUser();
    super.initState();
    Timer(
      Duration(seconds: 5),
      () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => OnBoard(),
          ),
          (routes) => false,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: customColor,
      ),
      body: NetworkSensitive(
        child: Center(
          child: Container(
            height: 400,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/logo.png'),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
