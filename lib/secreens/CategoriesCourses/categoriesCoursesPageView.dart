import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/localization/localization_constants.dart';
import 'package:elgawda/models/InstructorApi.dart';
import 'package:elgawda/models/categoriesApi.dart';
import 'package:elgawda/models/prodact.dart';
import 'package:elgawda/models/userData.dart';
import 'package:elgawda/secreens/my%20courses/components/videoscreens.dart';
import 'package:elgawda/secreens/my%20courses/mycoursesdetails.dart';
import 'package:elgawda/secreens/wrapper/wrapper.dart';
import 'package:elgawda/services/dbhelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:elgawda/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  bool loading = false;

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
      appBar: AppBar(
        title: Text(widget.courses.name),
      ),
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
                        '${widget.courses.price} ' +
                            getTranslated(context, 'KD'),
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
            color: customColorbottomBar.withOpacity(.5),
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
                (loading)
                    ? Center(child: CircularProgressIndicator())
                    : Expanded(
                        flex: 1,
                        child: iconCouresBoton(
                          icon: Icons.favorite,
                          title: (widget.courses.in_wish_list == 1)
                              ? getTranslated(context, 'remove_to_wishlist')
                              : getTranslated(context, 'add_to_wishlist'),
                          onTap: () {
                            setState(() {
                              loading = !loading;
                            });
                            addToWishList();
                          },
                        ),
                      ),
                (widget.courses.enrolled == 1)
                    ? iconCouresBoton(
                        title: getTranslated(context, 'course'),
                        icon: FontAwesomeIcons.youtube,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  MyCoursesDetails(
                                courses: widget.courses,
                              ),
                            ),
                          );
                        })
                    : (cantAdd)
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
                                            dis: double.parse(widget
                                                .courses.discount
                                                .toString()),
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
                                          dis: double.parse(widget
                                              .courses.discount
                                              .toString()),
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
                        widget.courses.sections[index]['lessons'].isEmpty
                            ? Container()
                            : ListTile(
                                title: Text(
                                  (widget.courses.sections[index]['name']) ??
                                      '',
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
                        widget.courses.sections[index]['lessons'].isEmpty
                            ? Container()
                            : Container(
                                // color: customColorbottomBar,
                                child: lectureDetaile(
                                    list: widget.courses.sections[index]
                                        ['lessons']),
                              ),
                      ],
                    );
                  },
                ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  lectureDetaile({var list}) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: list.length,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      itemBuilder: (context, index) {
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${index + 1}',
                  style: AppTheme.heading.copyWith(
                    fontSize: 25,
                  ),
                ),
                SizedBox(width: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 110,
                          child: Text(
                            list[index]['name'],
                            style: AppTheme.heading,
                          ),
                        ),
                      ],
                    ),
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
            Divider(
              color: customColorDivider,
              thickness: 1,
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

  addToWishList() async {
    try {
      var response = await http.post(
        Utils.MyWishList_URL,
        body: {
          'course_id': widget.courses.id.toString(),
        },
        headers: {
          'x-api-key': User.userToken,
          'lang': apiLang(),
        },
      );
      print(response.statusCode);

      Map<String, dynamic> map = json.decode(response.body);
      print(map);
      if (map['success'] == false) {
        setState(() {
          loading = !loading;
        });
        showMyDialog(
          isTrue: false,
          context: context,
          message: map['message'].toString(),
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => Wrapper(),
              ),
            );
          },
        );
      } else {
        setState(() {
          loading = !loading;
        });
        showMyDialog(
          isTrue: (widget.courses.in_wish_list == 1) ? false : true,
          context: context,
          message: (widget.courses.in_wish_list == 1)
              ? getTranslated(context, 'removeCourse')
              : getTranslated(context, 'addCourse'),
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => Wrapper(),
              ),
            );
          },
        );
      }
    } catch (e) {
      setState(() {
        loading = !loading;
      });
      showMyDialog(
        isTrue: false,
        context: context,
        message: getTranslated(context, 'catchError'),
        onTap: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => Wrapper(),
            ),
          );
        },
      );
      print('whtis List errororororr');
      print(e.toString());
    }
  }
}
