import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/localization/localization_constants.dart';
import 'package:elgawda/secreens/authenticate/authenticate.dart';
import 'package:elgawda/secreens/splashscreen.dart';
import 'package:elgawda/services/network_sensitive.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:elgawda/models/utils.dart';
import 'dart:convert';

bool loading = false;

class ResetPassword extends StatefulWidget {
  final String email;

  const ResetPassword({Key key, this.email}) : super(key: key);
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  String confPassword;
  String password;
  bool obscureconPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customColor,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: (loading)
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : NetworkSensitive(
                child: ListView(
                  shrinkWrap: true,
                  primary: true,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  children: [
                    LogoContainar(),
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getTranslated(context, 'Reset_Password'),
                              style: AppTheme.heading.copyWith(
                                color: customColor,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 40),
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
                                getTranslated(context, 'confirm_the_password'),
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
                                confPassword,
                              ),
                              obscureText: obscureconPassword,
                              onChanged: (val) {
                                setState(() {
                                  confPassword = val;
                                });
                              },
                            ),
                            CustomButton(
                              text: getTranslated(context, 'send'),
                              onPress: () {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    loading = !loading;
                                  });
                                  changePassword();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
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
    } else if (password != confrimPassord) {
      return getTranslated(context, "password_not_mat");
    } else {
      return null;
    }
  }

  changePassword() async {
    try {
      var response = await http.post(
        Utils.ResetForgetPassword_URL,
        body: {
          'email': widget.email,
          'password': password,
          'password_confirmation': confPassword,
        },
        headers: {
          'lang': apiLang(),
        },
      );

      Map<String, dynamic> map = json.decode(response.body);

      if (map['success'] == true) {
        setState(() {
          loading = !loading;
        });
        showMyDialog(
          isTrue: false,
          context: context,
          message: map['message'],
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => Authenticate(),
          ),
        );
      } else {
        setState(() {
          loading = !loading;
        });
        showMyDialog(
          isTrue: false,
          context: context,
          message: map['message'],
        );
      }
    } catch (e) {
      setState(() {
        loading = !loading;
      });
      print('Cash Forgtin  Password Errro');

      showMyDialog(
        isTrue: false,
        context: context,
        message: getTranslated(context, 'catchError'),
        onTap: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => SplashScreen(),
            ),
          );
        },
      );

      print(e.toString());
    }
  }
}
