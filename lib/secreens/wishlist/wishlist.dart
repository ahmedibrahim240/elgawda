import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/localization/localization_constants.dart';
import 'package:elgawda/models/courses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Wishlist extends StatefulWidget {
  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(
        context: context,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.graduationCap,
              color: customColor,
            ),
            SizedBox(width: 20),
            Text(
              getTranslated(context, 'wishlist'),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: coursesList.length,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(coursesList[index].image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        coursesList[index].title,
                        style: AppTheme.headingColorBlue,
                      ),
                      Text(
                        coursesList[index].lecTitle,
                        style: AppTheme.subHeadingColorBlue,
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
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Divider(
                color: customColorDivider,
                thickness: 2,
              ),
              SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }
}
