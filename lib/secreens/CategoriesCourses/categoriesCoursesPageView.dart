import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/models/InstructorApi.dart';
import 'package:elgawda/secreens/my%20courses/components/videoscreens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoriesCoursesPageView extends StatefulWidget {
  final CouresesModels courses;

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
          (Uri.parse(widget.courses.mp4Link).isAbsolute)
              ? Container(
                  height: 200,
                  child: ChewieVideo(url: widget.courses.mp4Link),
                )
              : Container(
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
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Courses ' + widget.courses.name,
                        style: AppTheme.headingColorBlue.copyWith(
                          color: customColorGold,
                          fontSize: 12,
                        ),
                      ),
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
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 30),
                      Text(
                        'Pri',
                        style: AppTheme.headingColorBlue.copyWith(
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 10),
                      (widget.courses.discount == '0' ||
                              widget.courses.discount == null)
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
                        style: (widget.courses.discount == '0' ||
                                widget.courses.discount == null)
                            ? AppTheme.headingColorBlue.copyWith(
                                fontSize: 12,
                                decoration: (widget.courses.discount == '0' ||
                                        widget.courses.discount == null)
                                    ? TextDecoration.none
                                    : TextDecoration.lineThrough,
                                color: customColor.withOpacity(.5),
                              )
                            : AppTheme.headingColorBlue.copyWith(
                                fontSize: 12,
                              ),
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
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'About ' + widget.courses.name,
                    style: AppTheme.heading.copyWith(
                      color: customColorGray,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    parseHtmlString((widget.courses.description) ?? ''),
                    style: AppTheme.subHeading.copyWith(
                      color: customColorGray,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
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
          ),
          SizedBox(height: 30),
          (widget.courses.sections.isEmpty)
              ? Container()
              : Container(
                  color: customColorbottomBar,
                  child: lectureDetaile(list: widget.courses.sections),
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

  lectureDetaile({var list}) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: list.length,
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
                          list[index]['name'],
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
