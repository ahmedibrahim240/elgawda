import 'package:elgawda/constants/constans.dart';
import 'package:flutter/material.dart';

class Utils {
  static bageColors({String bage}) {
    Color color;
    switch (bage) {
      case 'Bestseller':
        color = Colors.green;
        return color;
        break;
      case 'Sale':
        color = Colors.red;
        return color;
        break;
      case 'Recent':
        color = customColorGold;
        return color;
        break;
    }
  }

  // ignore: non_constant_identifier_names
  static final BASE_URL = "http://api.jawda-academy.com/api";
  // ignore: non_constant_identifier_names
  static final Consultant_URL = BASE_URL + "/consultants";
  // ignore: non_constant_identifier_names
  static final RATE_URL = BASE_URL + "/rates/consultant";
  // ignore: non_constant_identifier_names
  static final REGISTER_URL = BASE_URL + "/clients/register";
  // ignore: non_constant_identifier_names
  static final REGISTERASCONSUL_URL = BASE_URL + "/requests";
  // ignore: non_constant_identifier_names
  static final LOGIN_URL = BASE_URL + "/clients/login";
  // ignore: non_constant_identifier_names
  static final GITUSERDATA_URL = BASE_URL + "/clients/profile";
  // ignore: non_constant_identifier_names
  static final UPDATEUSERDATA_URL = BASE_URL + "/clients/update";
  // ignore: non_constant_identifier_names
  static final CHANGEPASSWORD_URL = BASE_URL + "/clients/change_password";
  // ignore: non_constant_identifier_names
  static final CHECKOUT_URL = BASE_URL + "/visits";
  // ignore: non_constant_identifier_names
  static final VISITS_URL = BASE_URL + "/visits";
  // ignore: non_constant_identifier_names
  static final SEARCHBYNAME_URL = BASE_URL + "/search?search=";
  // ignore: non_constant_identifier_names
  static final CONSULTFILLTER_URL = BASE_URL + "/filter";
  // ignore: non_constant_identifier_names
  static final CONTACTUS_URL = BASE_URL + "/send_message";
  // ignore: non_constant_identifier_names
  static final SETTINGES_URL = BASE_URL + "/settings";
  // ignore: non_constant_identifier_names
  static final AboutUS_URL = BASE_URL + "/about";
}
