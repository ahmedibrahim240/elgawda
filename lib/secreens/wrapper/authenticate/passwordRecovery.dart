import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/secreens/wrapper/authenticate/restPassword/confirmPassword.dart';
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
        child: ListView(
          shrinkWrap: true,
          primary: true,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          children: [
            LogoContainar(),
            SizedBox(height: 40),
            Text(
              'Password Recovery',
              style: AppTheme.headingColorBlue.copyWith(
                fontSize: 15,
                color: customColor,
              ),
            ),
            Text(
              "Please enter a valid email",
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
                      validator: (val) =>
                          val.isEmpty ? 'please enter your phone email' : null,
                      onChanged: (val) {},
                      decoration: textFormInputDecoration(
                        Icons.email,
                        "Email",
                      ),
                    ),
                    SizedBox(height: 30),
                    CustomButton(
                      text: 'send',
                      onPress: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ConfirmPassword(),
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
    );
  }
}
