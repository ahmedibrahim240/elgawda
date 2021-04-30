import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/localization/localization_constants.dart';
import 'package:elgawda/models/categoriesApi.dart';
import 'package:elgawda/secreens/my%20courses/components/videoscreens.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class MyCoursesVideoPage extends StatefulWidget {
  final String title;
  final String videoId;

  const MyCoursesVideoPage({Key key, this.title, this.videoId})
      : super(key: key);
  @override
  _MyCoursesVideoPageState createState() => _MyCoursesVideoPageState();
}

class _MyCoursesVideoPageState extends State<MyCoursesVideoPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: (widget.videoId == '')
          ? Center(
              child: Container(
                child: Text(
                  getTranslated(context, 'Course_avilable'),
                  style: AppTheme.heading,
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : FutureBuilder(
              future: CategoriesApi.getVideoMp4Link(id: widget.videoId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  return (snapshot.data == null || snapshot.data.isEmpty)
                      ? Center(
                          child: Container(
                            child: Text(
                              getTranslated(context, 'Course_avilable'),
                              style: AppTheme.heading,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          child: ChewieVideo(
                            url: snapshot.data,
                          ),
                        );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
    );
  }
}
