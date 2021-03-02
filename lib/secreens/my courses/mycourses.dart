import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/models/courses.dart';
import 'package:elgawda/secreens/editprofile/editprofile.dart';
import 'package:elgawda/secreens/notifications/notifications.dart';
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
      appBar: myCorsesAppBar(),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: coursesList.length,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        itemBuilder: (context, index) {
          return Column(
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
                      image: DecorationImage(
                        image: NetworkImage(coursesList[index].image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        coursesList[index].title,
                        style: AppTheme.headingColorBlue,
                      ),
                      Text(
                        coursesList[index].lecTitle,
                        style: AppTheme.subHeadingColorBlue,
                      ),
                      Row(
                        children: [
                          RatingStar(
                            rating: coursesList[index].rate,
                          ),
                          SizedBox(width: 5),
                          Text(
                            '${coursesList[index].rate}',
                            style: AppTheme.subHeading.copyWith(
                              fontSize: 10,
                              color: customColorGold,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            '(${coursesList[index].numPeopleRating})',
                            style: AppTheme.subHeading.copyWith(
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
          );
        },
      ),
    );
  }

  myCorsesAppBar() {
    return AppBar(
      toolbarHeight: 80,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            FontAwesomeIcons.graduationCap,
            color: customColor,
          ),
          SizedBox(width: 20),
          Text('My Courses'),
        ],
      ),
      leading: InkWell(
        onTap: () {
          flitter(
            context: context,
            child: EditProfile(),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: CircleAvatar(
            maxRadius: 50,
            backgroundColor: customColor,
            backgroundImage: AssetImage('lib/images/user.jpg'),
          ),
        ),
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
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => Notificatios(),
                ),
              );
            },
            child: Icon(
              Icons.notifications,
              color: customColor,
            ),
          ),
        ),
      ],
    );
  }
}
