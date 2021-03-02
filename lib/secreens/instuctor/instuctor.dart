import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/models/instructor.dart';
import 'package:elgawda/secreens/home/instractorlistvie.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AllInstuctor extends StatefulWidget {
  @override
  _AllInstuctorState createState() => _AllInstuctorState();
}

class _AllInstuctorState extends State<AllInstuctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.graduationCap,
              color: customColor,
            ),
            SizedBox(width: 20),
            Text('instructor'),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {},
              child: Icon(
                Icons.search,
                color: customColorDivider,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        primary: false,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        children: [
          Text(
            'instructor',
            style: AppTheme.headingColorBlue.copyWith(
              fontSize: 16,
            ),
          ),
          InstractorListView(),
        ],
      ),
    );
  }
}
