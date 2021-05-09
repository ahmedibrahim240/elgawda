import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/localization/localization_constants.dart';
import 'package:elgawda/models/aboutUs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
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
                          boxFit: BoxFit.cover,
                          context: context,
                          url: snapshot.data.imageUrl,
                        ),
                ),
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: cutomHttpWidget(data: snapshot.data.contant),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
