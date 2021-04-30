import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/localization/localization_constants.dart';
import 'package:elgawda/models/InstructorApi.dart';
import 'package:elgawda/models/categoriesApi.dart';
import 'package:elgawda/secreens/chatRome.dart/chatRome.dart';
import 'package:elgawda/secreens/my%20courses/components/videoscreens.dart';
import 'package:elgawda/secreens/my%20courses/components/vidoePage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class MyCoursesDetails extends StatefulWidget {
  final CouresesModels courses;

  const MyCoursesDetails({Key key, @required this.courses}) : super(key: key);
  @override
  _MyCoursesDetailsState createState() => _MyCoursesDetailsState();
}

class _MyCoursesDetailsState extends State<MyCoursesDetails> {
  int lecTapped = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        shrinkWrap: true,
        primary: true,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
          courseDetail(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                taps(
                  index: 0,
                  title: 'Lecture',
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
                  title: 'More',
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
                  title: 'Review',
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
                  title: 'Chat',
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
                      ? reviewBody()
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
          'Description',
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
                rating: 2.5,
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
                    labelText: 'Comment',
                  ),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {},
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
                        'Rating',
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
              return ListView(
                shrinkWrap: true,
                primary: false,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      'Section ${index + 1} - ' +
                          widget.courses.sections[index]['name'],
                      style: AppTheme.subHeading.copyWith(
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                  lectureDetaile(
                    list: widget.courses.sections[index]['lessons'],
                    quizes: widget.courses.sections[index]['lessons'],
                  ),
                ],
              );
            },
          );
  }

  ListView lectureDetaile({var list, var quizes}) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: list.length,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => MyCoursesVideoPage(
                  title: list[index]['name'],
                  videoId: list[index]['vimeo_id'] ?? '',
                ),
              ),
            );
          },
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
                      // Text(
                      //   'Video -10.22 '+list[index]['name'],
                      //   style: AppTheme.subHeading.copyWith(
                      //     color: Colors.grey[400],
                      //   ),
                      // ),
                      (quizes.isEmpty)
                          ? Container()
                          : TextButton(
                              onPressed: () {},
                              child: Text(
                                '${quizes.length} Quizs',
                                style: AppTheme.heading.copyWith(
                                  color: customColorGold,
                                ),
                              ),
                            )
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
