import 'dart:ui';

import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/models/categoories.dart';
import 'package:elgawda/models/utils.dart';
import 'package:elgawda/secreens/CategoriesCourses/categoriesCoursesPageView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoriesCoursesPage extends StatefulWidget {
  final Categories categories;

  const CategoriesCoursesPage({Key key, @required this.categories})
      : super(key: key);
  @override
  _CategoriesCoursesPageState createState() => _CategoriesCoursesPageState();
}

class _CategoriesCoursesPageState extends State<CategoriesCoursesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        shrinkWrap: true,
        primary: true,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        children: [
          Text(
            widget.categories.name,
            style: AppTheme.headingColorBlue.copyWith(
              fontSize: 20,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: widget.categories.courses.length,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => CategoriesCoursesPageView(
                        courses: widget.categories.courses[index],
                      ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                  widget.categories.courses[index].image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.categories.courses[index].title,
                              style: AppTheme.headingColorBlue.copyWith(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              widget.categories.courses[index].lecTitle,
                              style: AppTheme.subHeading.copyWith(
                                color: customColorGold,
                                fontSize: 10,
                              ),
                            ),
                            Row(
                              children: [
                                RatingStar(
                                  rating: widget.categories.courses[index].rate,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  widget.categories.courses[index].rate
                                      .toString(),
                                  style: AppTheme.subHeading.copyWith(
                                    fontSize: 10,
                                    color: customColorGold,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '(${widget.categories.courses[index].numPeopleRating})',
                                  style: AppTheme.subHeading.copyWith(
                                    fontSize: 10,
                                    color: customColorGold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Utils.bageColors(
                                  bage: widget.categories.courses[index].badge,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  widget.categories.courses[index].badge,
                                  style: AppTheme.subHeadingColorBlue.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  widget.categories.courses[index].oldPrice
                                          .toString() +
                                      '\$',
                                  style: AppTheme.headingColorBlue.copyWith(
                                    color: customColorDivider,
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 10,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  widget.categories.courses[index].newPrice
                                          .toString() +
                                      '\$',
                                  style: AppTheme.subHeading.copyWith(
                                    color: customColorGold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
