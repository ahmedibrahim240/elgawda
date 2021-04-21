import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/models/courses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoriesCoursesPageView extends StatefulWidget {
  final Courses courses;

  const CategoriesCoursesPageView({Key key, @required this.courses})
      : super(key: key);
  @override
  _CategoriesCoursesPageViewState createState() =>
      _CategoriesCoursesPageViewState();
}

class _CategoriesCoursesPageViewState extends State<CategoriesCoursesPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        shrinkWrap: true,
        primary: true,
        children: [
          SizedBox(height: 10),
          Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: customCachedNetworkImage(
                context: context,
                url: widget.courses.image,
              ),
            ),
          ),
          ListView(
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Courses ' + widget.courses.title,
                        style: AppTheme.headingColorBlue.copyWith(
                          color: customColorGold,
                          fontSize: 12,
                        ),
                      ),
                      Row(
                        children: [
                          RatingStar(
                            rating: widget.courses.rate,
                          ),
                          SizedBox(width: 5),
                          Text(
                            widget.courses.rate.toString(),
                            style: AppTheme.subHeading.copyWith(
                              fontSize: 10,
                              color: customColorGold,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            '(${widget.courses.numPeopleRating})',
                            style: AppTheme.subHeading.copyWith(
                              fontSize: 10,
                              color: customColorGold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        widget.courses.oldPrice.toString() + '\$',
                        style: AppTheme.subHeading.copyWith(
                          color: customColorGray,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        widget.courses.newPrice.toString() + '\$',
                        style: AppTheme.headingColorBlue.copyWith(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: customColorbottomBar,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About this course',
                  style: AppTheme.heading.copyWith(
                    color: customColorGray,
                  ),
                ),
                Text(
                  widget.courses.contant +
                      widget.courses.contant +
                      widget.courses.contant,
                  // textAlign: TextAlign.justify,
                  style: AppTheme.subHeading.copyWith(
                    color: customColorGray,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                iconCouresBoton(
                  icon: Icons.favorite,
                  title: 'Add to wachlist',
                ),
                iconCouresBoton(
                  icon: FontAwesomeIcons.shoppingCart,
                  title: 'Add to Cart',
                ),
                iconCouresBoton(
                  icon: FontAwesomeIcons.solidShareSquare,
                  title: 'Share',
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Container(
            color: customColorbottomBar,
            child: lectureDetaile(),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: customRaiseButtom(
              text: 'Enroll Now',
              onTap: () {},
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  lectureDetaile() {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: 4,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      itemBuilder: (context, index) {
        return Column(
          children: [
            Row(
              children: [
                Text(
                  '${index + 1}',
                  style: AppTheme.heading.copyWith(
                    fontSize: 25,
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                          child: Center(
                            child: Icon(
                              FontAwesomeIcons.check,
                              color: Colors.white,
                              size: 10,
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Welcom to 2 course',
                          style: AppTheme.heading,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Video -10.22 mins-Resources (1)',
                      style: AppTheme.subHeading.copyWith(
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  iconCouresBoton({String title, IconData icon}) {
    return InkWell(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: customColor,
            size: 35,
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: AppTheme.headingColorBlue.copyWith(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
