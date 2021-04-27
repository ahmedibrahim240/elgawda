import 'dart:async';

import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/localization/localization_constants.dart';
import 'package:flutter/material.dart';
import 'package:code_fields/code_fields.dart';

class ConfirmPassword extends StatefulWidget {
  final String email;

  const ConfirmPassword({Key key, @required this.email}) : super(key: key);
  @override
  _ConfirmPasswordState createState() => _ConfirmPasswordState();
}

class _ConfirmPasswordState extends State<ConfirmPassword> {
  final _formKey = GlobalKey<FormState>();
  final int codeLength = 4;
  int counter = 60;
  Timer _timer;

  String validateCode(String code) {
    if (code.length < codeLength)
      return "من فضلك اكمل الكود";
    else {
      bool isNumeric = int.tryParse(code) != null;
      if (!isNumeric) return "برجاء ادخال الكود المرسل";
    }
    return null;
  }

  startTimer() {
    counter = 60;
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        setState(() {
          if (counter > 0) {
            counter--;
          } else {
            _timer.cancel();
          }
        });
      },
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
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
                      getTranslated(context, 'Confrim'),
                      style: AppTheme.heading.copyWith(
                        color: customColor,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 40),
                    Center(
                      child: Text(
                        getTranslated(context, 'code_sent') +
                            '\n' +
                            widget.email,
                        textAlign: TextAlign.center,
                        style: AppTheme.subHeading.copyWith(),
                      ),
                    ),
                    SizedBox(height: 40),
                    Center(
                      child: CodeFields(
                        length: codeLength,
                        onCompleted: (val) {
                          _timer.cancel();
                          print(val);

                          Navigator.of(context).pop();
                        },
                        onChanged: (val) {
                          print(val);
                        },
                        validator: validateCode,
                        textStyle: TextStyle(color: Colors.black),
                        autofocus: true,
                      ),
                    ),
                    SizedBox(height: 20),
                    (counter > 0)
                        ? Center(
                            child: Text(
                              counter.toString(),
                              style: AppTheme.headingColorBlue.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        : Center(
                            child: InkWell(
                              onTap: () {
                                startTimer();
                              },
                              child: Text(
                                getTranslated(context, 'ResendCode') + " ?",
                                style: AppTheme.headingColorBlue.copyWith(),
                              ),
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
