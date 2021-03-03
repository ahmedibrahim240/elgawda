import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/models/userData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  bool obscurePassword = true;
  String phoneNamber;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          primary: false,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          children: [
            Center(
              child: Text(
                'Edit Profile',
                style: AppTheme.headingColorBlue.copyWith(fontSize: 15),
              ),
            ),
            SizedBox(height: 10),
            Hero(
              tag: 'UserImage',
              child: Container(
                height: 160,
                width: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(userDate.userImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name',
                    style: AppTheme.headingColorBlue.copyWith(fontSize: 15),
                  ),
                  TextFormField(
                    initialValue: userDate.userName,
                    decoration: textFormInpuofEidtProfile(icon: Icons.edit),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Phone Number',
                    style: AppTheme.headingColorBlue.copyWith(fontSize: 15),
                  ),
                  TextFormField(
                    initialValue: userDate.userPhoneNamber,
                    decoration: textFormInpuofEidtProfile(),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Email',
                    style: AppTheme.headingColorBlue.copyWith(fontSize: 15),
                  ),
                  TextFormField(
                    initialValue: userDate.userEmail,
                    decoration: textFormInpuofEidtProfile(icon: Icons.edit),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Passord',
                    style: AppTheme.headingColorBlue.copyWith(fontSize: 15),
                  ),
                  TextFormField(
                    initialValue: '********',
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
                  Center(
                    child: CustomButton(
                      onPress: () {},
                      text: 'Save',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
