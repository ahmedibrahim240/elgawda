import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/localization/localization_constants.dart';
import 'package:elgawda/models/MyCourses.dart';
import 'package:elgawda/secreens/my%20courses/mycoursesdetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyCourses extends StatefulWidget {
  @override
  _MyCoursesState createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(
        context: context,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.graduationCap,
              color: customColor,
            ),
            SizedBox(width: 20),
            Text(
              getTranslated(context, 'my_courses'),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: MyCoursesApi.fetchMyCourses(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return (snapshot.data.isEmpty)
                ? Container()
                : ListView(
                    shrinkWrap: true,
                    primary: true,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => MyCoursesDetails(
                                    courses: snapshot.data[index],
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 130,
                                      width: 130,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: customCachedNetworkImage(
                                          context: context,
                                          url: snapshot.data[index].image_path,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data[index].name,
                                          style: AppTheme.headingColorBlue,
                                        ),
                                        Text(
                                          (snapshot.data[index]
                                                  .instructorName) ??
                                              '',
                                          style: AppTheme.subHeadingColorBlue,
                                        ),
                                        (snapshot.data[index].rate == "0")
                                            ? Container()
                                            : Row(
                                                children: [
                                                  RatingStar(
                                                    rating: double.parse(
                                                        snapshot
                                                            .data[index].rate),
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    '${snapshot.data[index].rate}',
                                                    style: AppTheme.subHeading
                                                        .copyWith(
                                                      fontSize: 10,
                                                      color: customColorGold,
                                                    ),
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    '(${snapshot.data[index].rate_count})',
                                                    style: AppTheme.subHeading
                                                        .copyWith(
                                                      fontSize: 10,
                                                      color: customColorGold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Divider(
                                  color: customColorDivider,
                                  thickness: 2,
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
