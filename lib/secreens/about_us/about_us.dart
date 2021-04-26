import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/localization/localization_constants.dart';
import 'package:elgawda/models/aboutUs.dart';
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
        title: Text(
          getTranslated(context, "about_us"),
        ),
      ),
      body: FutureBuilder(
        future: AboutUSApi.gitAboutUSApi(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return ListView(
              shrinkWrap: true,
              primary: true,
              children: [
                Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: (snapshot.data.imageUrl == null)
                        ? Container(
                            child: Icon(
                              Icons.image,
                              color: Colors.lightBlueAccent,
                            ),
                          )
                        : customCachedNetworkImage(
                            context: context,
                            url: snapshot.data.imageUrl,
                          )),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Text(
                    parseHtmlString(snapshot.data.contant),
                    style: AppTheme.subHeading.copyWith(
                      height: 1.5,
                      letterSpacing: .07,
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
