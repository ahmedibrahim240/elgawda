import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/models/categoriesApi.dart';
import 'package:elgawda/models/utils.dart';
import 'package:elgawda/secreens/CategoriesCourses/categoriesCoursesPageView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoriesCoursesPage extends StatefulWidget {
  final String name;
  final int id;

  const CategoriesCoursesPage({Key key, this.name, this.id}) : super(key: key);
  @override
  _CategoriesCoursesPageState createState() => _CategoriesCoursesPageState();
}

class _CategoriesCoursesPageState extends State<CategoriesCoursesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: CategoriesApi.fetchCategrsCoursesByid(widget.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return (snapshot.data.isEmpty)
                ? Container()
                : ListView(
                    shrinkWrap: true,
                    primary: true,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    children: [
                      Text(
                        widget.name,
                        style: AppTheme.headingColorBlue.copyWith(
                          fontSize: 20,
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: snapshot.data.length,
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => CategoriesCoursesPageView(
                                    courses: snapshot.data[index],
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
                                      ),
                                      child: customCachedNetworkImage(
                                        context: context,
                                        boxFit: BoxFit.contain,
                                        url: snapshot.data[index].image_path,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data[index].name,
                                          style: AppTheme.headingColorBlue
                                              .copyWith(
                                            fontSize: 12,
                                          ),
                                        ),
                                        (snapshot.data[index].instructorName ==
                                                null)
                                            ? Container()
                                            : Text(
                                                snapshot
                                                    .data[index].instructorName,
                                                style: AppTheme.subHeading
                                                    .copyWith(
                                                  color: customColorGold,
                                                  fontSize: 10,
                                                ),
                                              ),
                                        (snapshot.data[index].rate == '0')
                                            ? Container()
                                            : Row(
                                                children: [
                                                  RatingStar(
                                                    rating: double.parse(
                                                        snapshot
                                                            .data[index].rate),
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    snapshot.data[index].rate
                                                        .toString(),
                                                    style: AppTheme.subHeading
                                                        .copyWith(
                                                      fontSize: 10,
                                                      color: customColorGold,
                                                    ),
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    '(${snapshot.data[index].rate_count})',
                                                    style: AppTheme.subHeading
                                                        .copyWith(
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Utils.bageColors(
                                              bage: snapshot.data[index].badges,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              snapshot.data[index].badges,
                                              style: AppTheme
                                                  .subHeadingColorBlue
                                                  .copyWith(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Text(
                                              'Pri',
                                              style: AppTheme.headingColorBlue
                                                  .copyWith(
                                                fontSize: 12,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            (snapshot.data[index].discount ==
                                                        null ||
                                                    snapshot.data[index]
                                                            .discount ==
                                                        '')
                                                ? Container()
                                                : Text(
                                                    newPrice(
                                                      price: double.parse(
                                                          snapshot.data[index]
                                                              .price),
                                                      dis: double.parse(
                                                        snapshot.data[index]
                                                            .discount,
                                                      ),
                                                    ).toString(),
                                                    style: AppTheme
                                                        .headingColorBlue
                                                        .copyWith(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                            SizedBox(width: 5),
                                            Text(
                                              '${snapshot.data[index].price}\$',
                                              style: (snapshot.data[index]
                                                              .discount ==
                                                          null ||
                                                      snapshot.data[index]
                                                              .discount ==
                                                          '')
                                                  ? AppTheme.headingColorBlue
                                                      .copyWith(
                                                      fontSize: 12,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      color: customColor
                                                          .withOpacity(.5),
                                                    )
                                                  : AppTheme.headingColorBlue
                                                      .copyWith(
                                                      fontSize: 12,
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
                  );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
