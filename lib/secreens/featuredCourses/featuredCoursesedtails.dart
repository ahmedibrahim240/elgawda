import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/models/InstructorApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeaturedCoursesedtails extends StatefulWidget {
  final CouresesModels courses;

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
                url: widget.courses.image_path,
              ),
            ),
          ),
          ListView(
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            children: [
              Text(
                'Courses ' + widget.courses.name,
                style: AppTheme.headingColorBlue.copyWith(
                  color: customColorGold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                parseHtmlString(widget.courses.description),
                textAlign: TextAlign.justify,
                style: AppTheme.subHeading.copyWith(
                  color: customColorGray,
                ),
              ),
              SizedBox(height: 20),
              (widget.courses.rate == '0')
                  ? Container()
                  : Row(
                      children: [
                        RatingStar(
                          rating: double.parse(widget.courses.rate),
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
                          '(${widget.courses.rate_count})',
                          style: AppTheme.subHeading.copyWith(
                            fontSize: 10,
                            color: customColorGold,
                          ),
                        ),
                      ],
                    ),
              SizedBox(height: 20),
              Text(
                widget.courses.badges,
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: iconCouresBoton(
                      icon: Icons.favorite,
                      title: 'Add to wachlist',
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: iconCouresBoton(
                      icon: FontAwesomeIcons.shoppingCart,
                      title: 'Add to Cart',
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: iconCouresBoton(
                      icon: FontAwesomeIcons.solidShareSquare,
                      title: 'Share',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        'Pri',
                        style: AppTheme.headingColorBlue.copyWith(
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 10),
                      (widget.courses.discount == null ||
                              widget.courses.discount == '')
                          ? Container()
                          : Text(
                              newPrice(
                                price: double.parse(widget.courses.price),
                                dis: double.parse(
                                  widget.courses.discount,
                                ),
                              ).toString(),
                              style: AppTheme.headingColorBlue.copyWith(
                                fontSize: 12,
                              ),
                            ),
                      SizedBox(width: 5),
                      Text(
                        '${widget.courses.price}\$',
                        style: (widget.courses.discount == null ||
                                widget.courses.discount == '')
                            ? AppTheme.headingColorBlue.copyWith(
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough,
                                color: customColor.withOpacity(.5),
                              )
                            : AppTheme.headingColorBlue.copyWith(
                                fontSize: 12,
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
            size: 30,
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: AppTheme.headingColorBlue.copyWith(
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
