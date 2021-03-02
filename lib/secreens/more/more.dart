import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/models/userData.dart';
import 'package:elgawda/secreens/about_us/about_us.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'components/Language.dart';
import 'components/moreUserData.dart';
import 'components/morebody.dart';

class More extends StatefulWidget {
  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  UserDate _userDate = UserDate(
    userName: 'Nada Draz',
    userEmail: 'Nada@gmaill.coom',
    userImage: 'lib/images/user.jpg',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          children: [
            MoreUserData(
              userDate: _userDate,
            ),
            SizedBox(height: 40),
            MoreBody(
              title: 'Cart',
              child: Icon(
                FontAwesomeIcons.shoppingCart,
                color: customColor,
              ),
              onTap: () {},
            ),
            SizedBox(height: 20),
            MoreBody(
              title: 'Contact Us',
              child: Icon(
                FontAwesomeIcons.solidAddressCard,
                color: customColor,
              ),
              onTap: () {},
            ),
            SizedBox(height: 20),
            MoreBody(
              title: 'About Us',
              child: Icon(
                Icons.info_outline,
                size: 30,
                color: customColor,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AboutUs(),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            MoreBody(
              title: 'Change Language',
              child: Language(),
              onTap: () {},
            ),
            SizedBox(height: 50),
            CustomButton(
              onPress: () {},
              text: 'Log Out',
            ),
          ],
        ),
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
