import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/localization/localization_constants.dart';
import 'package:elgawda/models/userData.dart';
import 'package:elgawda/models/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';

import '../sharedPreferences.dart';

class DatabaseServices {
  final String userToken;
  final BuildContext context;
  final controller = StreamController<Users>();
  DatabaseServices({@required this.context, this.userToken});
  Map<String, dynamic> map;
  gituserData() async {
    try {
      var response = await http
          .get(Utils.GITUSERDATA_URL, headers: {'x-api-key': userToken});
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(response.statusCode.toString());
        final user = _userFromDatabaseUser(data, context);
        controller.add(user);
      } else if (response.statusCode == 201) {
        final data = json.decode(response.body);

        final user = _userFromDatabaseUser(data, context);
        controller.add(user);
      } else {
        print(response.statusCode.toString());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Users _userFromDatabaseUser(Map user, BuildContext context) {
    return user != null
        ? Users(
            name: user['data']['name'].toString(),
            image: user['data']['image'].toString(),
            userId: user['data']['id'],
            moblie: (user['data']['mobile'] != null)
                ? user['data']['mobile'].toString()
                : getTranslated(context, 'addPhone'),
            email: (user['data']['email'] != null)
                ? user['data']['email'].toString()
                : getTranslated(context, 'addEmail'),
          )
        : null;
  }

  upDateUserData(
      {String mobile,
      String password,
      String name,
      File images,
      String email,
      BuildContext context}) async {
    try {
      var data;
      if (images == null) {
        data = FormData.fromMap({
          "email": '$email',
          'name': "$name",
          'password': "$password",
          'password_confirmation': "$password",
          "image": null,
          'mobile': "$mobile",
        });
      } else {
        String image = images.path.split('/').last;
        data = FormData.fromMap({
          "email": '$email',
          'name': "$name",
          'password': "$password",
          'password_confirmation': "$password",
          "image": await MultipartFile.fromFile(
            images.path,
            filename: image,
          ),
          'mobile': "$mobile",
        });
      }

      Dio dio = new Dio();

      dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
        var customHeaders = {
          'x-api-key': userToken,
        };
        options.headers.addAll(customHeaders);
        return options;
      }));

      Response response = await dio.post(Utils.UPDATEUSERDATA_URL, data: data);

      if (response.data['success'] == true) {
        if (password != User.userPassword) {
          MySharedPreferences.saveUserUserPassword(password);
        }
        showMyDialog(context: context, message: 'تم حفظ التغير بنجاح');
      } else {
        showMyDialog(
            context: context, message: response.data['message'].toString());
      }
    } catch (e) {
      print('errrrroe Upadata Data');
      showMyDialog(context: context, message: 'فشل التغير.....');

      print(e.toString());
    }
  }

  Stream<Users> get userData {
    gituserData();
    return controller.stream;
  }
}

Future<void> showMyDialog({BuildContext context, var message}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                message,
                style: AppTheme.heading.copyWith(
                  color: customColor,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'الغاء',
              style: AppTheme.heading.copyWith(
                color: customColor,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class Users {
  final int userId;
  final String moblie;
  final String name;
  final String image;
  final String email;

  Users({
    this.image,
    this.name,
    this.email,
    this.moblie,
    this.userId,
  });
}