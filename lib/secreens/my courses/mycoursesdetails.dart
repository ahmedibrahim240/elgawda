import 'dart:async';

import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/localization/localization_constants.dart';
import 'package:elgawda/models/InstructorApi.dart';
import 'package:elgawda/models/categoriesApi.dart';
import 'package:elgawda/models/quizes.dart';
import 'package:elgawda/models/userData.dart';
import 'package:elgawda/secreens/chatRome.dart/chatRome.dart';
import 'package:elgawda/secreens/my%20courses/QuizesPage.dart';
import 'package:elgawda/secreens/my%20courses/components/videoscreens.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:elgawda/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyCoursesDetails extends StatefulWidget {
  final CouresesModels courses;

  const MyCoursesDetails({Key key, @required this.courses}) : super(key: key);
  @override
  _MyCoursesDetailsState createState() => _MyCoursesDetailsState();
}

class _MyCoursesDetailsState extends State<MyCoursesDetails> {
  int lecTapped = 0;
  double rating = 2.0;
  String comment;
  bool loading = false;
  String videoId;
  int taped = 0;
  int counter = 3;
  Timer _timer;
  getVideoID({int id}) {
    if (widget.courses.sections.isEmpty) {
      print('isEmpaty');
      setState(() {
        videoId = widget.courses.vimeo_code;
      });
    } else {
      print(id);
      if (id == null) {
        setState(() {
          videoId = widget.courses.sections[0]['lessons'][0]['vimeo_id'];
        });
      } else {
        print(
            'widget.courses.sections[0][lessons][id][vimeo_id]:${widget.courses.sections[0]['lessons'][id]['vimeo_id']}');
        setState(() {
          videoId = widget.courses.sections[0]['lessons'][id]['vimeo_id'];
        });
        startTimer();
      }
    }
  }

  startTimer() {
    counter = 3;
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        setState(() {
          if (counter > 0) {
            counter--;
          } else {
            _timer.cancel();
            setState(() {
              loading = false;
            });
          }
        });
      },
    );
  }

  @override
  void initState() {
    getVideoID();
    super.initState();
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
        // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        children: [
          (loading == true)
              ? Center(child: CircularProgressIndicator())
              : (videoId != '' && videoId != null)
                  ? FutureBuilder(
                      future: CategoriesApi.getVideoMp4Link(
                        id: videoId,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return (snapshot.data == null ||
                                  snapshot.data.isEmpty)
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
          courseDetail(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                taps(
                  index: 0,
                  title: getTranslated(context, 'Lectures'),
                  onTap: () {
                    setState(
                      () {
                        lecTapped = 0;
                      },
                    );
                  },
                ),
                SizedBox(width: 20),
                taps(
                  index: 1,
                  title: getTranslated(context, 'more'),
                  onTap: () {
                    setState(
                      () {
                        lecTapped = 1;
                      },
                    );
                  },
                ),
                SizedBox(width: 20),
                taps(
                  index: 2,
                  title: getTranslated(context, 'Review'),
                  onTap: () {
                    setState(
                      () {
                        lecTapped = 2;
                      },
                    );
                  },
                ),
                SizedBox(width: 20),
                taps(
                  index: 3,
                  title: getTranslated(context, 'Chat'),
                  onTap: () {
                    setState(
                      () {
                        lecTapped = 3;
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          (lecTapped == 0)
              ? lectureBody()
              : (lecTapped == 1)
                  ? more()
                  : (lecTapped == 2)
                      ? (loading)
                          ? Center(child: CircularProgressIndicator())
                          : reviewBody()
                      : ChatRome(
                          id: widget.courses.id,
                        ),
        ],
      ),
    );
  }

  more() {
    return ListView(
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.symmetric(horizontal: 20),
      children: [
        Text(
          getTranslated(context, 'Description'),
          style: AppTheme.heading.copyWith(
            color: customColor,
            fontSize: 20,
          ),
        ),
        Text(
          parseHtmlString(widget.courses.description),
          style: AppTheme.subHeadingColorBlue,
        ),
      ],
    );
  }

  sentRating() async {
    try {
      var response = await http.post(
        Utils.Rate_course_URL,
        body: {
          'comment': 'comment',
          'rate': rating.toString(),
          'course_id': widget.courses.id.toString(),
        },
        headers: {
          'x-api-key': User.userToken,
          'lang': apiLang(),
        },
      );
      print(response.statusCode);

      var map = json.decode(response.body);
      if (map['success'] == false) {
        setState(() {
          loading = !loading;
        });
        showMyDialog(
          isTrue: false,
          context: context,
          message: map['message'].toString(),
        );
      } else {
        setState(() {
          loading = !loading;
        });
        showMyDialog(
          isTrue: true,
          context: context,
          message: 'success',
        );
      }
      print(map);
    } catch (e) {
      setState(() {
        loading = !loading;
      });
      showMyDialog(
        isTrue: false,
        context: context,
        message: getTranslated(context, 'catchError'),
      );
      print(e);
    }
  }

  Container reviewBody() {
    return Container(
      child: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmoothStarRating(
                rating: rating,
                onRated: (val) {
                  setState(() {
                    rating = val;
                  });
                },
                size: 25,
                filledIconData: Icons.star,
                color: Colors.yellow[700],
                halfFilledIconData: Icons.star_half,
                borderColor: Colors.yellow[900],
                defaultIconData: Icons.star_border,
                starCount: 5,
                allowHalfRating: true,
                spacing: 2.0,
              ),
              SizedBox(height: 10),
              Container(
                height: 100,
                child: TextFormField(
                  expands: true,
                  maxLines: null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: customColorGray),
                      gapPadding: 10,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: customColorGray),
                      gapPadding: 10,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    labelStyle: AppTheme.heading.copyWith(
                      color: customColorGray,
                    ),
                    labelText: getTranslated(context, 'Comment'),
                  ),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  setState(() {
                    loading = !loading;
                  });
                  sentRating();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: customColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        getTranslated(context, 'Rating'),
                        style: AppTheme.heading.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell taps({Function onTap, String title, int index}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            title,
            style: AppTheme.subHeading.copyWith(
              color: (lecTapped == index) ? Colors.black : Colors.grey[400],
            ),
          ),
          SizedBox(
            width: 50,
            child: Divider(
              color: (lecTapped == index) ? Colors.black : Colors.transparent,
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }

  lectureBody() {
    return (widget.courses.sections.isEmpty)
        ? Center(
            child: Text(
              getTranslated(context, 'Course_avilable'),
              style: AppTheme.heading,
              textAlign: TextAlign.center,
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: widget.courses.sections.length,
            itemBuilder: (context, index) {
              return widget.courses.sections[index]['lessons'].isEmpty
                  ? Container()
                  : ListView(
                      shrinkWrap: true,
                      primary: false,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Text(
                            getTranslated(context, 'Section') +
                                    ' ${index + 1} - ' +
                                    widget.courses.sectionsList[index].name ??
                                "",
                            style: AppTheme.subHeading.copyWith(
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                        widget.courses.sections[index]['lessons'].isEmpty
                            ? Container()
                            : lectureDetaile(
                                list: widget.courses.sections[index]['lessons'],
                                quizes:
                                    widget.courses.sectionsList[index].quizes,
                                i: index,
                              ),
                      ],
                    );
            },
          );
  }

  ListView lectureDetaile({var list, List<Quizes> quizes, int i}) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: list.length + 1,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            if (index == list.length) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => QuizesPage(
                    quizes: quizes,
                  ),
                ),
              );
            } else {
              setState(() {
                loading = true;
                getVideoID(id: index);
                taped = index;
              });

              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (_) => MyCoursesVideoPage(
              //       title: list[index]['name'] ?? '',
              //       videoId: list[index]['vimeo_id'] ?? '',
              //     ),
              //   ),
              // );
            }
          },
          child: (index == list.length)
              ? (i > quizes.length - 1)
                  ? Container()
                  : Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
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
                                      // Container(
                                      //   height: 20,
                                      //   width: 20,
                                      //   decoration: BoxDecoration(
                                      //     shape: BoxShape.circle,
                                      //     color: Colors.green,
                                      //   ),
                                      //   child: Center(
                                      //     child: Icon(
                                      //       FontAwesomeIcons.check,
                                      //       color: Colors.white,
                                      //       size: 10,
                                      //     ),
                                      //   ),
                                      // ),
                                      SizedBox(width: 5),
                                      Text(
                                        getTranslated(context, 'Quizes'),
                                        style: AppTheme.heading,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(
                            color: customColorDivider,
                            thickness: 2,
                          ),
                        ],
                      ),
                    )
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  color: (taped == index)
                      ? Color(0xfff85f3e5).withOpacity(.2)
                      : Colors.white,
                  child: Column(
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
                                  // Container(
                                  //   height: 20,
                                  //   width: 20,
                                  //   decoration: BoxDecoration(
                                  //     shape: BoxShape.circle,
                                  //     color: Colors.green,
                                  //   ),
                                  //   child: Center(
                                  //     child: Icon(
                                  //       FontAwesomeIcons.check,
                                  //       color: Colors.white,
                                  //       size: 10,
                                  //     ),
                                  //   ),
                                  // ),
                                  SizedBox(width: 5),
                                  Text(
                                    list[index]['name'] ?? "",
                                    style: AppTheme.heading,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              // Text(
                              //   'Video -10.22 '+list[index]['name'],
                              //   style: AppTheme.subHeading.copyWith(
                              //     color: Colors.grey[400],
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        color: customColorDivider,
                        thickness: 2,
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }

  courseDetail() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.courses.name,
            style: AppTheme.subHeadingColorBlue,
          ),
          (widget.courses.rate == "0")
              ? Container(
                  height: 20,
                )
              : Row(
                  children: [
                    RatingStar(
                      rating: double.parse(widget.courses.rate),
                    ),
                    SizedBox(width: 5),
                    Text(
                      '${widget.courses.rate}',
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
    );
  }
}

// ignore: must_be_immutable
class LectureDetaile extends StatefulWidget {
  var list;
  final List<Quizes> quizes;
  final int i;

  LectureDetaile({Key key, this.list, this.quizes, this.i}) : super(key: key);
  @override
  _LectureDetaileState createState() => _LectureDetaileState();
}

class _LectureDetaileState extends State<LectureDetaile> {
  int taped = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: widget.list.length + 1,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            if (index == widget.list.length) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => QuizesPage(
                    quizes: widget.quizes,
                  ),
                ),
              );
            } else {
              setState(() {
                taped = index;
              });
              print(taped);

              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (_) => MyCoursesVideoPage(
              //       title: widget. list[index]['name'] ?? '',
              //       videoId: widget. list[index]['vimeo_id'] ?? '',
              //     ),
              //   ),
              // );
            }
          },
          child: (index == widget.list.length)
              ? (widget.i > widget.quizes.length - 1)
                  ? Container()
                  : Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
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
                                      // Container(
                                      //   height: 20,
                                      //   width: 20,
                                      //   decoration: BoxDecoration(
                                      //     shape: BoxShape.circle,
                                      //     color: Colors.green,
                                      //   ),
                                      //   child: Center(
                                      //     child: Icon(
                                      //       FontAwesomeIcons.check,
                                      //       color: Colors.white,
                                      //       size: 10,
                                      //     ),
                                      //   ),
                                      // ),
                                      SizedBox(width: 5),
                                      Text(
                                        getTranslated(context, 'Quizes'),
                                        style: AppTheme.heading,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(
                            color: customColorDivider,
                            thickness: 2,
                          ),
                        ],
                      ),
                    )
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  color: (taped == index)
                      ? Color(0xfff85f3e5).withOpacity(.2)
                      : Colors.white,
                  child: Column(
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
                                  // Container(
                                  //   height: 20,
                                  //   width: 20,
                                  //   decoration: BoxDecoration(
                                  //     shape: BoxShape.circle,
                                  //     color: Colors.green,
                                  //   ),
                                  //   child: Center(
                                  //     child: Icon(
                                  //       FontAwesomeIcons.check,
                                  //       color: Colors.white,
                                  //       size: 10,
                                  //     ),
                                  //   ),
                                  // ),
                                  SizedBox(width: 5),
                                  Text(
                                    widget.list[index]['name'] ?? "",
                                    style: AppTheme.heading,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              // Text(
                              //   'Video -10.22 '+list[index]['name'],
                              //   style: AppTheme.subHeading.copyWith(
                              //     color: Colors.grey[400],
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        color: customColorDivider,
                        thickness: 2,
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
