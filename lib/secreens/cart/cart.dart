import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/models/courses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: ListView(
        shrinkWrap: true,
        primary: false,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          Text(
            'Training Courses',
            style: AppTheme.headingColorBlue.copyWith(fontSize: 16),
          ),
          ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: 2,
            itemBuilder: (context, index) {
              return trainingCourses(
                index: index,
                onTap: () {},
              );
            },
          ),
          Divider(
            color: customColor,
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total',
                style: AppTheme.headingColorBlue.copyWith(fontSize: 16),
              ),
              SizedBox(width: 20),
              Text(
                '100 \$',
                style: AppTheme.headingColorBlue
                    .copyWith(fontSize: 16, color: customColorGold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  trainingCourses({int index, Function onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(
                      coursesList[index].image,
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 196,
                  child: Text(
                    coursesList[index].title,
                    style: AppTheme.headingColorBlue.copyWith(fontSize: 10),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 196,
                  child: Text(
                    coursesList[index].contant,
                    style: AppTheme.subHeading.copyWith(
                      fontSize: 9,
                      color: customColorGold,
                    ),
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
                Align(
                  child: Row(
                    children: [
                      SizedBox(width: 50),
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
                ),
              ],
            ),
            Center(
              child: InkWell(
                onTap: () {},
                child: CircleAvatar(
                  minRadius: 12,
                  backgroundColor: customColor,
                  child: Center(
                    child: Text(
                      'x',
                      style: AppTheme.heading
                          .copyWith(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
