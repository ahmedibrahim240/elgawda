import 'package:elgawda/constants/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  String conatant =
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage('lib/images/aboutus.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 30),
          Text(
            conatant + conatant + conatant + conatant + conatant,
            textAlign: TextAlign.justify,
            style: AppTheme.subHeadingColorBlue,
          ),
        ],
      ),
    );
  }
}
