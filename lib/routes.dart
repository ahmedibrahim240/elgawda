import 'package:elgawda/secreens/home/home.dart';
import 'package:elgawda/secreens/splashscreen.dart';
import 'package:elgawda/secreens/wrapper/wrapper.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes = {
  Home.route: (_) => Home(),
  SplashScreen.route: (_) => SplashScreen(),
  Wrapper.route: (_) => Wrapper(),
};
