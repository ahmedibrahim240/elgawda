import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:flutter/material.dart';

import 'package:code_fields/code_fields.dart';

import 'chagePassword.dart';

class VerifyPhone extends StatefulWidget {
  @override
  _VerifyPhoneState createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
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

  // void onButtonPressed() {
  //   if (_formKey.currentState.validate()) {
  //     _formKey.currentState.save();
  //     Navigator.of(context).push(
  //       MaterialPageRoute(
  //         builder: (_) => ChagePassrowd(),
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customColor,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
                CustomAppBar(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('lib/images/logo.png'),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 220, left: 30, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Please enter the sent code",
                        style: AppTheme.heading.copyWith(
                          color: customColor,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "A code has been sent to a number" + ' 0102412151',
                        style: AppTheme.subHeading.copyWith(),
                      ),
                      SizedBox(height: 40),
                      Center(
                        child: CodeFields(
                          length: codeLength,
                          validator: validateCode,
                          textStyle: TextStyle(color: Colors.white),
                          autofocus: true,
                          inputDecoration: InputDecoration(
                            filled: true,
                            fillColor: customColor,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24.0),
                              borderSide: BorderSide(
                                style: BorderStyle.solid,
                                color: customColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24.0),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24.0),
                              borderSide: BorderSide(color: customColor),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Not sent",
                            style: AppTheme.heading.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "Resend!",
                              style: AppTheme.heading.copyWith(
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      CustomButton(
                        text: 'send',
                        onPress: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ChagePassrowd(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
