import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/localization/localization_constants.dart';
import 'package:elgawda/models/userData.dart';
import 'package:elgawda/models/utils.dart';
import 'package:elgawda/secreens/wrapper/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../sharedPreferences.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String phoneNumber;
  String password;
  String confirmPassword;
  String name;
  String email;

  bool obscurePassword = true;
  bool obscureconPassword = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: customColor,
        toolbarHeight: 0,
      ),
      body: (loading)
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : ListView(
              shrinkWrap: true,
              primary: true,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              children: [
                LogoContainar(),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      getTranslated(context, 'create'),
                      style: AppTheme.heading.copyWith(
                        color: customColorGold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      getTranslated(context, 'an_account'),
                      style: AppTheme.heading.copyWith(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 15),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextFormField(
                                style: TextStyle(color: Colors.black),
                                validator: (val) => val.isEmpty
                                    ? getTranslated(context, 'valid_name')
                                    : null,
                                onChanged: (val) {
                                  setState(() {
                                    name = val;
                                  });
                                },
                                decoration: textFormInputDecoration(
                                  Icons.person,
                                  getTranslated(context, 'full_name'),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                style: TextStyle(color: Colors.black),
                                validator: (val) => val.isEmpty
                                    ? getTranslated(context, 'valid_phone')
                                    : null,
                                onChanged: (val) {
                                  setState(() {
                                    phoneNumber = val;
                                  });
                                },
                                decoration: textFormInputDecoration(
                                  Icons.phone,
                                  getTranslated(context, 'phone_numer'),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(color: Colors.black),
                                validator: (val) => val.isEmpty
                                    ? getTranslated(context, 'valid_email')
                                    : null,
                                onChanged: (val) {
                                  setState(() {
                                    email = val;
                                  });
                                },
                                decoration: textFormInputDecoration(
                                  Icons.email,
                                  getTranslated(context, 'email'),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                style: TextStyle(color: Colors.black),
                                decoration: textFormInputDecorationForPassword(
                                  Icons.visibility_off,
                                  getTranslated(context, 'password'),
                                  () {
                                    setState(() {
                                      obscurePassword = !obscurePassword;
                                    });
                                  },
                                  obscurePassword,
                                ),
                                validator: (val) => validatePassord(val),
                                obscureText: obscurePassword,
                                onChanged: (val) {
                                  setState(() {
                                    password = val;
                                  });
                                },
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                style: TextStyle(color: Colors.black),
                                decoration: textFormInputDecorationForPassword(
                                  Icons.visibility_off,
                                  getTranslated(
                                      context, 'confirm_the_password'),
                                  () {
                                    setState(() {
                                      obscureconPassword = !obscureconPassword;
                                    });
                                  },
                                  obscureconPassword,
                                ),
                                validator: (val) => validateConfrimPassord(
                                  val,
                                  password,
                                  confirmPassword,
                                ),
                                obscureText: obscureconPassword,
                                onChanged: (val) {
                                  setState(() {
                                    confirmPassword = val;
                                  });
                                },
                              ),
                              SizedBox(height: 10),
                              CustomButton(
                                onPress: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      loading = true;
                                    });

                                    registerWithPhoneAndPassword(
                                      name: name,
                                      password_confirmation: confirmPassword,
                                      email: email,
                                      mobile: phoneNumber,
                                      password: password,
                                    );
                                  }
                                },
                                text: getTranslated(context, 'sign_up'),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 1,
                                    width: width * .3,
                                    color: customColor,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    getTranslated(context, 'or'),
                                    style: AppTheme.headingColorBlue.copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Container(
                                    height: 1,
                                    width: width * .3,
                                    color: customColor,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        getTranslated(
                                            context, 'already_have_an_account'),
                                        style: AppTheme.subHeadingColorBlue
                                            .copyWith(
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(' '),
                                      InkWell(
                                        onTap: () => widget.toggleView(),
                                        child: Text(
                                          getTranslated(context, 'sign_in'),
                                          style: AppTheme.headingColorBlue
                                              .copyWith(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.google,
                                        color: Colors.redAccent,
                                        size: 35,
                                      ),
                                      SizedBox(width: 30),
                                      Icon(
                                        FontAwesomeIcons.facebook,
                                        color: Colors.blueAccent,
                                        size: 35,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  registerWithPhoneAndPassword({
    // ignore: non_constant_identifier_names
    String mobile,
    // ignore: non_constant_identifier_names
    String email,
    // ignore: non_constant_identifier_names
    String name,
    // ignore: non_constant_identifier_names
    String password_confirmation,
    // ignore: non_constant_identifier_names
    String password,
  }) async {
    try {
      // Dio dio = new Dio();

      var response = await http.post(
        Utils.REGISTER_URL,
        // Utils.REGISTER_URL,
        body: {
          'name': name,
          'email': email,
          'mobile': mobile,
          'password': password,
          'password_confirmation': password_confirmation,
        },
      );

      Map<String, dynamic> map = json.decode(response.body);
      print('stuates Code:${response.statusCode}');

      if (map['success'] == true) {
        setState(() {
          User.userToken = map['data']['api_token'].toString();
        });
        MySharedPreferences.saveUserUserToken(
          map['data']['api_token'].toString(),
        );

        MySharedPreferences.saveUserSingIn(true);
        MySharedPreferences.saveUserSkipLogIn(false);
        MySharedPreferences.saveUserUserPassword(password);

        User.userLogIn = await MySharedPreferences.getUserSingIn();
        User.userSkipLogIn = await MySharedPreferences.getUserSkipLogIn();

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => Wrapper(),
          ),
        );
      } else {
        setState(() {
          loading = false;
        });
        showMyDialog(context: context, message: map['message'].toString());
      }

      // Navigator.pop(context);
    } catch (e) {
      print('Cash Resster Errro');
      setState(() {
        loading = false;
      });
      showMyDialog(
        context: context,
        message: getTranslated(context, 'catchError'),
      );

      print(e.toString());
    }
  }

  String validatePassord(String val) {
    if (val.isEmpty) {
      return getTranslated(context, "valid_password");
    } else if (val.length < 6) {
      return getTranslated(context, "valid_password_len");
    } else {
      return null;
    }
  }

  String validateConfrimPassord(
    String val,
    String password,
    String confrimPassord,
  ) {
    if (val.isEmpty) {
      return getTranslated(context, "valid_password");
    } else if (password != confirmPassword) {
      return getTranslated(context, "password_not_mat");
    } else {
      return null;
    }
  }
}
