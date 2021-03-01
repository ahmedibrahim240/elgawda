import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:flutter/material.dart';

import '../../wrapper.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  bool obscureconPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customColor,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                        "Reset Password",
                        style: AppTheme.heading.copyWith(
                          color: customColor,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 40),
                      TextFormField(
                        style: TextStyle(color: Colors.black),
                        obscureText: obscurePassword,
                        decoration: textFormInputDecorationForPassword(
                          Icons.visibility_off,
                          'password',
                          () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                          obscurePassword,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        obscureText: obscureconPassword,
                        decoration: textFormInputDecorationForPassword(
                          Icons.visibility_off,
                          'Confirm the password',
                          () {
                            setState(() {
                              obscureconPassword = !obscureconPassword;
                            });
                          },
                          obscureconPassword,
                        ),
                      ),
                      SizedBox(height: 50),
                      Center(
                        child: CustomButton(
                          text: 'send',
                          onPress: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => Wrapper(),
                              ),
                            );
                          },
                        ),
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
}
