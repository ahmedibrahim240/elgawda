import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/localization/localization_constants.dart';
import 'package:elgawda/models/userData.dart';
import 'package:elgawda/secreens/wrapper/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:elgawda/models/utils.dart';
import 'dart:convert';

import '../../../sharedPreferences.dart';
import '../passwordRecovery.dart';

class LogIn extends StatefulWidget {
  final Function toggleView;
  LogIn({this.toggleView});
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  bool obscurePassword = true;
  String phoneNamber;
  String password;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
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
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              children: [
                LogoContainar(),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      getTranslated(context, 'Welcome'),
                      style: AppTheme.heading.copyWith(
                        color: customColorGold,
                        fontSize: 20,
                      ),
                    ),
                    Text(' '),
                    Text(
                      getTranslated(context, 'Back'),
                      style: AppTheme.heading.copyWith(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '!',
                      style: AppTheme.heading.copyWith(
                        color: customColorGold,
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
                      primary: true,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextFormField(
                                style: TextStyle(color: Colors.black),
                                keyboardType: TextInputType.text,
                                decoration: textFormInputDecoration(
                                  Icons.login,
                                  getTranslated(
                                      context, 'email_or_phone_number'),
                                ),
                                validator: (val) => val.isEmpty
                                    ? getTranslated(
                                        context, 'valid_email_phone')
                                    : null,
                                onChanged: (val) {
                                  setState(() {
                                    phoneNamber = val;
                                  });
                                },
                              ),
                              SizedBox(height: 20),
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
                                validator: (val) => val.isEmpty
                                    ? getTranslated(context, 'valid_password')
                                    : null,
                                obscureText: obscurePassword,
                                onChanged: (val) {
                                  setState(() {
                                    password = val;
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

                                    logInWithPhoneAndPassword(
                                      phoneNummber: phoneNamber,
                                      password: password,
                                    );
                                  }
                                },
                                text: getTranslated(context, 'sign_in'),
                              ),
                              SizedBox(height: 12),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => PasswordRecovery(),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      getTranslated(context, 'forget_password'),
                                      style:
                                          AppTheme.headingColorBlue.copyWith(),
                                    ),
                                  ],
                                ),
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
                                            context, "don't_have_an_account"),
                                        style: AppTheme.subHeadingColorBlue
                                            .copyWith(
                                          fontSize: 12,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () => widget.toggleView(),
                                        child: Text(
                                          getTranslated(context, "sign_up"),
                                          style: AppTheme.headingColorBlue
                                              .copyWith(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        loading = !loading;
                                      });
                                      _googleLogIn();
                                    },
                                    child: Icon(
                                      FontAwesomeIcons.google,
                                      color: Colors.redAccent,
                                      size: 35,
                                    ),
                                  ),
                                  SizedBox(width: 30),
                                  InkWell(
                                    onTap: () {},
                                    child: Icon(
                                      FontAwesomeIcons.facebook,
                                      color: Colors.blueAccent,
                                      size: 35,
                                    ),
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
                SizedBox(height: 20),
              ],
            ),
    );
  }

  logInWithPhoneAndPassword({
    String phoneNummber,
    String password,
  }) async {
    try {
      var response = await http.post(Utils.LOGIN_URL, body: {
        'email': phoneNummber,
        'password': password,
      }, headers: {
        'lang': apiLang(),
      });

      Map<String, dynamic> map = json.decode(response.body);

      if (map['success'] == true) {
        setState(() {
          User.userToken = map['data']['api_token'].toString();
        });
        MySharedPreferences.saveUserSingIn(true);
        MySharedPreferences.saveUserSkipLogIn(false);
        MySharedPreferences.saveUserUserPassword(password);

        MySharedPreferences.saveUserUserToken(
          map['data']['api_token'].toString(),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => Wrapper(),
          ),
        );
      } else {
        setState(() {
          showMyDialog(context: context, message: map['message'].toString());

          loading = false;
        });
      }

      // Navigator.pop(context);
    } catch (e) {
      print('Cash LogIn Errro');

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

  _loginWithGOOGLe({googleID, name}) async {
    try {
      var response = await http.post(
        Utils.GOOGLE_URL,
        body: {
          'google_id': googleID,
          'name': name,
        },
        headers: {
          'lang': apiLang(),
        },
      );
      print(response.statusCode);

      Map<String, dynamic> map = json.decode(response.body);
      print(map);

      // print('this is the userData data ${userData}');
      if (map['success'] == true) {
        setState(() {
          User.userToken = map['data']['api_token'].toString();
        });
        MySharedPreferences.saveUserSingIn(true);
        MySharedPreferences.saveUserSkipLogIn(false);

        MySharedPreferences.saveUserUserName(
          map['data']['name'].toString(),
        );

        MySharedPreferences.saveUserUserToken(
          map['data']['api_token'].toString(),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => Wrapper(),
          ),
        );
      } else {
        setState(() {
          error = map['message'].toString();
          loading = !loading;
        });
      }

      // Navigator.pop(context);
    } catch (e) {
      setState(() {
        loading = !loading;
      });
      showMyDialog(
        context: context,
        message: getTranslated(context, 'catchError'),
      );
      print(
          'Catchhhhhhhhhhhhhhhhhhhhhhh errororororrorrorooroeoreoroeroeorero');
      print(e.toString());
    }
  }

  _googleLogIn() async {
    try {
      GoogleSignIn _googleSginIn = GoogleSignIn(scopes: ['email']);
      await _googleSginIn.signIn();
      setState(() {
        loading = !loading;
      });
      print(_googleSginIn.currentUser.displayName);
      print(_googleSginIn.currentUser.id);

      _loginWithGOOGLe(
        googleID: _googleSginIn.currentUser.id,
        name: _googleSginIn.currentUser.displayName,
      );
    } catch (e) {
      print("catssssssssss eroooooooooooooor");
      print(e.toString());
    }
  }
}
