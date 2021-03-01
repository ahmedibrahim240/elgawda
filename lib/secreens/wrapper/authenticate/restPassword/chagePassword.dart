import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:flutter/material.dart';

class ChagePassrowd extends StatefulWidget {
  @override
  _ChagePassrowdState createState() => _ChagePassrowdState();
}

class _ChagePassrowdState extends State<ChagePassrowd> {
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
                        "Create a new password",
                        style: AppTheme.heading.copyWith(
                          color: customColor,
                          fontSize: 25,
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
                      SizedBox(height: 20),
                      CustomButton(
                        text: 'send',
                        onPress: () {},
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
