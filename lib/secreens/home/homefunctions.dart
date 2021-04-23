import 'package:carousel_slider/carousel_slider.dart';
import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/models/courses.dart';
import 'package:elgawda/secreens/CategoriesCourses/categoriesCoursesPageView.dart';
import 'package:elgawda/secreens/featuredCourses/featuredCoursesedtails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Container sectionTitle({String title, Function onTap}) {
  return Container(
    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
    child: Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTheme.headingColorBlue.copyWith(fontSize: 16),
          ),
        ),
        TextButton(
          onPressed: onTap,
          child: Text(
            'View All',
            style: AppTheme.subHeading.copyWith(
              fontSize: 12,
              color: customColorGold,
            ),
          ),
        ),
      ],
    ),
  );
}

//////////////////////////////////////////////////////////////////////
featuredSections({@required BuildContext context}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Featured',
        style: AppTheme.headingColorBlue.copyWith(fontSize: 16),
      ),
      SizedBox(height: 10),
      Container(
        margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
        height: 300,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: coursesList.length,
          itemBuilder: (context, index) {
            return featuerd(
              index: index,
              context: context,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => FeaturedCoursesedtails(
                      courses: coursesList[index],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    ],
  );
}

//////////////////////////////////////////////////////////////////////

featuerd({int index, Function onTap, @required BuildContext context}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: 180,
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: customCachedNetworkImage(
                context: context,
                url: coursesList[index].image,
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: Text(
              coursesList[index].title,
              style: AppTheme.headingColorBlue.copyWith(fontSize: 12),
            ),
          ),
          Text(
            coursesList[index].lecTitle,
            style: AppTheme.subHeading.copyWith(
              fontSize: 10,
              color: customColorGold,
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
          Row(
            children: [
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
        ],
      ),
    ),
  );
}
//////////////////////////////////////////////////////////////////////

homePoster(BuildContext context) {
  return Container(
    child: Column(
      children: <Widget>[
        CarouselSlider(
          options: CarouselOptions(
            autoPlayInterval: Duration(seconds: 2),
            autoPlay: true,
            // reverse: widget.reverse,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.scale,
          ),
          items: coursesList
              .map(
                (items) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => CategoriesCoursesPageView(
                          courses: items,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          child: Stack(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                child: Container(
                                  width: 300,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                  ),
                                  child: customCachedNetworkImage(
                                    context: context,
                                    url: items.image,
                                  ),
                                ),
                              ),
                              Container(
                                width: 300,
                                height: 140,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                ),
                                child: Container(
                                  height: 100,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20.0),
                                      bottomRight: Radius.circular(20.0),
                                    ),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(200, 0, 0, 0),
                                        Color.fromARGB(0, 0, 0, 0)
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        items.title,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    ),
  );
}
//////////////////////////////////////////////////////////////////////

/////////////////////////////
