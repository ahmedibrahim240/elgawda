import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/localization/localization_constants.dart';
import 'package:elgawda/models/InstructorApi.dart';
import 'package:elgawda/models/categoriesApi.dart';
import 'package:elgawda/models/prodact.dart';
import 'package:elgawda/secreens/my%20courses/components/videoscreens.dart';
import 'package:elgawda/services/dbhelper.dart';
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
  DbHehper helper;
  bool cantAdd = false;
  var courseFromSQL;
  getCouresByIdFlomSQl() async {
    courseFromSQL = await helper.getProductById(widget.courses.id);

    if (courseFromSQL != null) {
      if (courseFromSQL.coursesId == widget.courses.id) {
        setState(() {
          cantAdd = true;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    helper = DbHehper();
    getCouresByIdFlomSQl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        shrinkWrap: true,
        primary: true,
        children: [
          (widget.courses.vimeo_code != '' && widget.courses.vimeo_code != null)
              ? FutureBuilder(
                  future: CategoriesApi.getVideoMp4Link(
                      id: widget.courses.vimeo_code),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data);
                      return (snapshot.data == null || snapshot.data.isEmpty)
                          ? Container()
                          : Container(
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              child: ChewieVideo(
                                url: snapshot.data,
                              ),
                            );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                )
              : Container(
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: customCachedNetworkImage(
                      boxFit: BoxFit.cover,
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
                        getTranslated(context, 'Courses') +
                            " " +
                            widget.courses.name,
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
                        getTranslated(context, 'price'),
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
                    getTranslated(context, 'about') + " " + widget.courses.name,
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
                    title: getTranslated(context, 'add_to_wishlist'),
                  ),
                ),
                (cantAdd)
                    ? Container()
                    : Expanded(
                        flex: 1,
                        child: iconCouresBoton(
                          icon: FontAwesomeIcons.shoppingCart,
                          title: getTranslated(context, 'add_to_cart'),
                          onTap: () async {
                            setState(() {
                              increaseCartTotlaPrice(
                                price: (widget.courses.discount == null)
                                    ? double.parse(
                                        widget.courses.price.toString())
                                    : newPrice(
                                        dis: double.parse(
                                            widget.courses.discount.toString()),
                                        price: double.parse(
                                          widget.courses.price.toString(),
                                        ),
                                      ),
                              );
                            });
                            CoursesProdect prodect = CoursesProdect({
                              'CoursesId': widget.courses.id,
                              'title': widget.courses.name,
                              'price': (widget.courses.discount == null)
                                  ? double.parse(
                                      widget.courses.price.toString())
                                  : newPrice(
                                      dis: double.parse(
                                          widget.courses.discount.toString()),
                                      price: double.parse(
                                        widget.courses.price.toString(),
                                      ),
                                    ),
                              'proImageUrl': widget.courses.image_path,
                            });
                            // ignore: unused_local_variable
                            int id = await helper.createProduct(prodect);
                            cardDialog(
                                context: context, message: 'Item Was Add');
                          },
                        ),
                      ),
                Expanded(
                  flex: 1,
                  child: iconCouresBoton(
                    icon: FontAwesomeIcons.solidShareSquare,
                    title: getTranslated(context, 'share'),
                    onTap: () {
                      share(
                        url: widget.courses.website_link,
                        title: widget.courses.name,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          (widget.courses.sections.isEmpty)
              ? Container()
              : ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: widget.courses.sections.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            (widget.courses.sections[index]['name']) ?? '',
                            style: AppTheme.headingColorBlue,
                          ),
                          subtitle: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Video -${widget.courses.sections[index]['featured_data']["total_time"]} mins-',
                                  style: AppTheme.subHeading.copyWith(
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Resources (${widget.courses.sections[index]['featured_data']["total_files"]})',
                                  style: AppTheme.subHeading.copyWith(
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: customColorbottomBar,
                          child: lectureDetaile(
                              list: widget.courses.sections[index]['lessons']),
                        ),
                      ],
                    );
                  },
                ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: customRaiseButtom(
              text: getTranslated(context, 'enroll_now'),
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
                      'Video -${list[index]["duration"]}',
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

  iconCouresBoton({String title, IconData icon, Function onTap}) {
    return InkWell(
      onTap: onTap,
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
            (title) ?? '',
            textAlign: TextAlign.center,
            style: AppTheme.headingColorBlue.copyWith(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
