import 'package:elgawda/secreens/wrapper/authenticate/register/register.dart';
import 'package:flutter/material.dart';

import 'logIn/login.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Container(
        child: LogIn(toggleView: toggleView),
      );
    } else {
      return Container(
        child: Register(toggleView: toggleView),
      );
    }
    // } else {
    //   return Home();
    // }
  }
}
