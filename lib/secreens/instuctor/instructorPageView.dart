import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/localization/localization_constants.dart';
import 'package:elgawda/models/courses.dart';
import 'package:elgawda/models/instructor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InstructorPageView extends StatefulWidget {
  final Instructor instructor;

  const InstructorPageView({Key key, @required this.instructor})
      : super(key: key);

  @override
  _InstructorPageViewState createState() => _InstructorPageViewState();
}

class _InstructorPageViewState extends State<InstructorPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        shrinkWrap: true,
        primary: false,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          instructorImage(),
          Text(
            getTranslated(context, 'bio'),
            style: AppTheme.headingColorBlue.copyWith(fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              widget.instructor.bio,
              style: AppTheme.subHeadingColorBlue.copyWith(fontSize: 14),
            ),
          ),
          Text(
                        getTranslated(context, 'Training_courses'),

            style: AppTheme.headingColorBlue.copyWith(fontSize: 16),
          ),
          ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: coursesList.length,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            itemBuilder: (context, index) {
              return trainingCourses(
                index: index,
                onTap: () {},
              );
            },
          ),
        ],
      ),
    );
  }

  trainingCourses({int index, Function onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(
                      coursesList[index].image,
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 185,
                  child: Text(
                    coursesList[index].title,
                    style: AppTheme.headingColorBlue.copyWith(fontSize: 10),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 185,
                  child: Text(
                    coursesList[index].contant,
                    style: AppTheme.subHeading.copyWith(
                      fontSize: 9,
                      color: customColorGold,
                    ),
                  ),
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
                Align(
                  child: Row(
                    children: [
                      SizedBox(width: 30),
                      Text(
                        'Pri',
                        style: AppTheme.headingColorBlue.copyWith(
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        '${coursesList[index].newPrice}\$',
                        style: AppTheme.headingColorBlue.copyWith(
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        '${coursesList[index].oldPrice}\$',
                        style: AppTheme.headingColorBlue.copyWith(
                          fontSize: 12,
                          decoration: TextDecoration.lineThrough,
                          color: customColor.withOpacity(.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  instructorImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.instructor.image),
                fit: BoxFit.cover,
              ),
              shape: BoxShape.circle),
        ),
        SizedBox(width: 20),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.instructor.insName,
              style: AppTheme.headingColorBlue.copyWith(fontSize: 16),
            ),
            Text(
              widget.instructor.insWork,
              style: AppTheme.subHeadingColorBlue.copyWith(fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }
}
