import 'dart:async';

import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:flutter/material.dart';

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
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 5),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => OnBoard(),
          ),
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: customColor,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              gradient: AppTheme.containerBackground,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 80),
              Center(
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/images/logo.png'),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              CircularProgressIndicator(),
            ],
          ),
        ],
      ),
    );
  }
}
