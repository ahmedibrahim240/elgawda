import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/secreens/wrapper/home/home.dart';
import 'package:flutter/material.dart';

import 'package:code_fields/code_fields.dart';

class ConfirmPassword extends StatefulWidget {
  @override
  _ConfirmPasswordState createState() => _ConfirmPasswordState();
}

class _ConfirmPasswordState extends State<ConfirmPassword> {
  final _formKey = GlobalKey<FormState>();
  final int codeLength = 4;

  String validateCode(String code) {
    if (code.length < codeLength)
      return "من فضلك اكمل الكود";
    else {
      bool isNumeric = int.tryParse(code) != null;
      if (!isNumeric) return "برجاء ادخال الكود المرسل";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customColor,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: ListView(
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
                      "Confirm",
                      style: AppTheme.heading.copyWith(
                        color: customColor,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 40),
                    Center(
                      child: Text(
                        "A code has been sent to an email" + '\n text@text.com',
                        textAlign: TextAlign.center,
                        style: AppTheme.subHeading.copyWith(),
                      ),
                    ),
                    SizedBox(height: 40),
                    Center(
                      child: CodeFields(
                        length: codeLength,
                        validator: validateCode,
                        textStyle: TextStyle(color: Colors.black),
                        autofocus: true,
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          "Resend code ?",
                          style: AppTheme.headingColorBlue.copyWith(),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: CustomButton(
                        text: 'send',
                        onPress: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => Home(),
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
    );
  }
}
