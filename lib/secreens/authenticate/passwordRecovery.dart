import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/localization/localization_constants.dart';
import 'package:elgawda/secreens/authenticate/register/confirmRegister.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:elgawda/models/utils.dart';
import 'dart:convert';

class PasswordRecovery extends StatefulWidget {
  @override
  _PasswordRecoveryState createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {
  final _formKey = GlobalKey<FormState>();
  bool verification = true;
  bool changePass = false;
  String email;
  bool loading = false;

  get customColor => null;
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
            : ListView(
                shrinkWrap: true,
                primary: true,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                children: [
                  LogoContainar(),
                  SizedBox(height: 40),
                  Text(
                    getTranslated(context, 'password_recovery'),
                    style: AppTheme.headingColorBlue.copyWith(
                      fontSize: 15,
                      color: customColor,
                    ),
                  ),
                  Text(
                    getTranslated(context, 'valid_email'),
                    style: AppTheme.subHeading.copyWith(),
                  ),
                  SizedBox(height: 40),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
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
                          SizedBox(height: 30),
                          CustomButton(
                            text: getTranslated(context, 'send'),
                            onPress: () {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = !loading;
                                });
                                sendForgetCode();
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
    );
  }

  sendForgetCode() async {
    try {
      var response = await http.post(
        Utils.SendForgetCode_URL,
        body: {
          'email': email,
        },
      );

      Map<String, dynamic> map = json.decode(response.body);

      if (map['success'] == true) {
        setState(() {
          loading = !loading;
        });
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => ConfirmPassword(
              email: email,
            ),
          ),
        );
      } else {
        setState(() {
          loading = !loading;
        });
        showMyDialog(
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
        context: context,
        message: getTranslated(context, 'catchError'),
      );

      print(e.toString());
    }
  }
}
