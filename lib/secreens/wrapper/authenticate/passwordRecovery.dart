import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/secreens/wrapper/authenticate/verfyPassword.dart';
import 'package:flutter/material.dart';

class PasswordRecovery extends StatefulWidget {
  @override
  _PasswordRecoveryState createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {
  final _formKey = GlobalKey<FormState>();
  bool verification = true;
  bool changePass = false;

  get customColor => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customColor,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Password Recovery',
                        style: AppTheme.heading.copyWith(
                          fontSize: 25,
                          color: customColor,
                        ),
                      ),
                      Text(
                        "Please enter a valid phone",
                        style: AppTheme.subHeading.copyWith(),
                      ),
                      SizedBox(height: 40),
                      TextFormField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: customColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: customColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      CustomButton(
                        text: 'send',
                        onPress: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => VerifyPhone(),
                            ),
                          );
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
}
