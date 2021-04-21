import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/models/courses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeaturedCoursesedtails extends StatefulWidget {
  final Courses courses;

  const FeaturedCoursesedtails({Key key, @required this.courses})
      : super(key: key);
  @override
  _FeaturedCoursesedtailsState createState() => _FeaturedCoursesedtailsState();
}

class _FeaturedCoursesedtailsState extends State<FeaturedCoursesedtails> {
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
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            children: [
              Text(
                'Courses ' + widget.courses.title,
                style: AppTheme.headingColorBlue.copyWith(
                  color: customColorGold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                widget.courses.contant + widget.courses.contant,
                // textAlign: TextAlign.justify,
                style: AppTheme.subHeading.copyWith(
                  color: customColorGray,
                ),
              ),
              SizedBox(height: 20),
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
              SizedBox(height: 20),
              Text(
                widget.courses.badge,
                style: AppTheme.heading.copyWith(
                  color: customColorGold,
                ),
              ),
              SizedBox(height: 10),
              coursesDetaile(
                iconData: Icons.person,
                title: 'Created by Ahmed Mohamed',
              ),
              SizedBox(height: 10),
              coursesDetaile(
                iconData: Icons.play_circle_fill,
                title: '23 total hours on video',
              ),
              SizedBox(height: 10),
              coursesDetaile(
                iconData: FontAwesomeIcons.book,
                title: '5 of PDF',
              ),
              SizedBox(height: 10),
              coursesDetaile(
                iconData: Icons.book,
                title: '15 Quiz after one section',
              ),
              SizedBox(height: 30),
              Row(
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
              SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '\$',
                        style: AppTheme.headingColorBlue.copyWith(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        widget.courses.newPrice.toString() + '\$',
                        style: AppTheme.headingColorBlue.copyWith(),
                      ),
                      SizedBox(width: 10),
                      Text(
                        widget.courses.oldPrice.toString() + '\$',
                        style: AppTheme.subHeading.copyWith(
                          color: customColorGray,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '90% off -2 days left a price',
                    style: AppTheme.headingColorBlue.copyWith(
                      fontSize: 14,
                      color: Colors.red,
                    ),
                  ),
                ],
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
        ],
      ),
    );
  }

  coursesDetaile({IconData iconData, String title}) {
    return Row(
      children: [
        Icon(
          iconData,
          color: customColorGold,
        ),
        SizedBox(width: 10),
        Text(
          title,
          style: AppTheme.heading.copyWith(
            color: customColorGray,
          ),
        )
      ],
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
