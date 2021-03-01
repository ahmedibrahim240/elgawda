import 'package:elgawda/secreens/splashscreen.dart';
import 'package:elgawda/secreens/wrapper/home/home.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes = {
  Home.route: (_) => Home(),
  SplashScreen.route: (_) => SplashScreen(),
};
