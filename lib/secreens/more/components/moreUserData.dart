import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/models/userData.dart';
import 'package:flutter/material.dart';

class MoreUserData extends StatefulWidget {
  final UserDate userDate;

  const MoreUserData({Key key, this.userDate}) : super(key: key);

  @override
  _MoreUserDataState createState() => _MoreUserDataState();
}

class _MoreUserDataState extends State<MoreUserData> {
  bool _isError = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          maxRadius: 45,
          backgroundColor: customColor,
          backgroundImage: AssetImage(widget.userDate.userImage),
          onBackgroundImageError: (_, __) {
            setState(() {
              this._isError = true;
            });
          },
          child: (this._isError) ? Icon(Icons.error) : Container(),
        ),
        SizedBox(width: 20),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.userDate.userName,
              style: AppTheme.headingColorBlue,
            ),
            Text(
              widget.userDate.userEmail,
              style: AppTheme.subHeadingColorBlue,
            ),
          ],
        ),
      ],
    );
  }
}
